require 'sqlite3'
require 'singleton'
require 'active_support/inflector'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class ModelBase

  def self.all
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT * FROM #{self.to_s.tableize}
    SQL
    data.map { |datum| self.new(datum) }
  end

  def save
    ivars = self.instance_variables.map { |ivar| ivar.to_s.delete('@') }
    ivar_values = ivars[1..-1].map{|ivar|self.send(ivar)}
    set_values = ivars[1..-1].map { |ivar| ivar + " = ?" }.join(" , ")
    if self.send(ivars.first) #update
      QuestionsDatabase.instance.execute(<<-SQL, *ivar_values, self.send(ivars.first))
        UPDATE
          #{self.class.to_s.tableize}
        SET
          #{set_values}
        WHERE
          id = ?
      SQL
      "ok"
    else #insert
      QuestionsDatabase.instance.execute(<<-SQL, *ivar_values)
      INSERT INTO
        #{self.class.to_s.tableize} (#{ivars[1..-1].join(', ')})
      VALUES
        (#{ivar_values.map{"?"}.join(", ")})
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

  def self.find_by_id(id)
    records = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.to_s.tableize}
      WHERE
        id = ?
    SQL

    return nil unless records.length > 0
    self.new(records.first)
  end

  def self.where(args)
    if args.is_a?(Hash)
      where_values = args.keys.map { |key| key.to_s + " = ?" }.join(" AND ")
      arg_val = args.values
    elsif args.is_a?(String)
      where_values = args
      arg_val = nil
    else
      raise "what's wrong with you"
    end
    found = QuestionsDatabase.instance.execute(<<-SQL, *arg_val)
        SELECT
          *
        FROM
          #{self.to_s.tableize}
        WHERE
          #{where_values}
      SQL
    return nil unless found.length > 0
    found.map { |record| self.new(record) }
  end

end

class User < ModelBase
  attr_accessor :id, :fname, :lname

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.find_by_name(fname, lname)
    users = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    return nil unless users.length > 0
    users.map { |user| User.new(user) }
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    avg_likes = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        COUNT(question_likes.question_id) /
        CAST(COUNT(DISTINCT questions.id) AS FLOAT) AS average_likes
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.question_id
      WHERE
        questions.user_id = ?
      SQL
      return 0 if avg_likes[0]['average_likes'].nil?
      avg_likes[0]['average_likes']
  end

end

class Question < ModelBase
  attr_accessor :id, :title, :body, :user_id

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def self.find_by_author_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = ?
    SQL

    return nil unless questions.length > 0
    questions.map { |question| Question.new(question) }
  end

  def author
    User.find_by_id(@user_id)
  end

  def replies
    Reply.find_by_user_id(@user_id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def most_liked(n)
    QuestionLike.most_liked_questions(n)
  end
end

class Reply < ModelBase
  attr_accessor :id, :reply_id, :body, :question_id, :user_id

  def initialize(options)
    @id = options['id']
    @reply_id = options['reply_id']
    @body = options['body']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def self.find_by_user_id(user_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    return nil unless replies.length > 0
    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    return nil unless replies.length > 0
    replies.map { |reply| Reply.new(reply) }
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_author_id(@user_id)
  end

  def parent_reply
    Reply.find_by_id(@reply_id)
  end

  def child_replies
    replies = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        reply_id = ?
    SQL

    return nil unless replies.length > 0
    replies.map { |reply| Reply.new(reply) }
  end

end

class QuestionFollow
  attr_accessor :question_id, :user_id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
    data.map { |datum| QuestionFollow.new(datum) }
  end

  def initialize(options)
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def self.followers_for_question_id(question_id)
    users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        user_id, fname, lname
      FROM
        question_follows
      JOIN
        users ON user_id = users.id
      WHERE
        question_id = ?
    SQL

    return nil unless users.length > 0
    users.map { |user| User.new(user) }
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id, title, body, questions.user_id
      FROM
        question_follows
      JOIN
        questions ON question_id = questions.id
      WHERE
        question_follows.user_id = ?
    SQL

    return nil unless questions.length > 0
    questions.map { |question| Question.new(question) }
  end

  def self.most_followed(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.id, title, body, questions.user_id,
        COUNT(questions.id) AS no_of_followers
      FROM
        question_follows
      JOIN
        questions ON question_id = questions.id
      GROUP BY
        question_follows.question_id
      ORDER BY
        no_of_followers DESC
      LIMIT
        ?
    SQL

    return nil unless questions.length > 0
    questions.map { |question| Question.new(question) }
  end
end

class QuestionLike
  attr_accessor :question_id, :user_id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
    data.map { |datum| QuestionLike.new(datum) }
  end

  def initialize(options)
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def self.likers_for_question_id(question_id)
    users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        user_id, fname, lname
      FROM
        question_likes
      JOIN
        users ON user_id = users.id
      WHERE
        question_id = ?
    SQL

    return nil unless users.length > 0
    users.map { |user| User.new(user) }
  end

  def self.num_likes_for_question_id(question_id)
    likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(question_id) AS no_of_likers
      FROM
        question_likes
      WHERE
        question_id = ?
    SQL

    return 0 unless likes.length > 0
    likes[0]['no_of_likers']
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id, title, body, questions.user_id
      FROM
        question_likes
      JOIN
        questions ON question_id = questions.id
      WHERE
        question_likes.user_id = ?
    SQL

    return nil unless questions.length > 0
    questions.map { |question| Question.new(question) }
  end

  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.id, title, body, questions.user_id,
        COUNT(questions.id) AS no_of_likers
      FROM
        question_likes
      JOIN
        questions ON question_id = questions.id
      GROUP BY
        question_likes.question_id
      ORDER BY
        no_of_likers DESC
      LIMIT
        ?
    SQL

    return nil unless questions.length > 0
    questions.map { |question| Question.new(question) }
  end

end
