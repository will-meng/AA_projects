def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie.select(:title, :id).joins(:actors)
    .where('actors.name IN (?)', those_actors).group(:id)
    .having('COUNT(*) = ?', those_actors.length)
end

def golden_age
  # Find the decade with the highest average movie score.

  # Movie.select('movies.yr , movies.yr / 10 * 10 AS decade, AVG(score) AS avg_score')
  #      .group('movies.yr / 10 * 10').order('avg_score DESC')

  arr = Movie.find_by_sql("
    SELECT
      yr / 10 * 10 AS decade
    FROM
      movies
    GROUP BY
      decade
    ORDER BY
      AVG(score) DESC
    LIMIT
      1
  ")
  arr.first.decade
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery
  Actor.joins(:castings).where('castings.movie_id IN (?)',
    Movie.joins(:actors).where('actors.name = ?', name).pluck(:id))
    .where.not(name: name).distinct.pluck(:name)


end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor.joins('left join castings ON actors.id = castings.actor_id')
       .where('castings.movie_id IS NULL').count
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"
  names = Actor.pluck(:name)
  whazzername.chars.uniq.each do |ch|
    i = 0
    while i < names.length
      if names[i].include?(ch)
        i += 1
      else
        names.delete_at(i)
      end
    end
  end
  p names
end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.
  Actor.select(:id, :name, 'MAX(movies.yr) - MIN(movies.yr) AS career')
       .joins(:movies)
       .group(:id)
       .order('career DESC, actors.name')
       .limit(3)
end
