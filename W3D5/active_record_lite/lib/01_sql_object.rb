require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    @columns || @columns = DBConnection
      .execute2("SELECT * FROM #{table_name}").first.map(&:to_sym)
  end

  def self.finalize!
    columns.each do |column|
      define_method(column) { attributes[column] }
      define_method("#{column}=") { |value| attributes[column] = value }
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.table_name = to_s.tableize
  end

  def self.all
    results = DBConnection.execute("SELECT * FROM #{table_name}")
    parse_all(results)
  end

  def self.parse_all(results)
    results.map { |attributes| self.new(attributes) }
  end

  def self.find(id)
    results = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        id = ?
      LIMIT
        1
    SQL

    return nil if results.empty?
    self.new(results.first)
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      if self.class.columns.include?(attr_name.to_sym)
        send("#{attr_name}=", value)
      else
        raise "unknown attribute '#{attr_name}'"
      end
    end
  end

  def attributes
    @attributes || @attributes = {}
  end

  def attribute_values
    self.class.columns.map { |attr_name| send(attr_name) }
  end

  def insert
    col_names = self.class.columns.join(', ')
    question_marks = (['?'] * self.class.columns.length).join(', ')

    DBConnection.execute(<<-SQL, attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    set_string = self.class.columns.drop(1)
      .map { |attr_name| "#{attr_name} = ?" }.join(' , ')

    DBConnection.execute(<<-SQL, attribute_values.drop(1), id)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_string}
      WHERE
        id = ?
    SQL
  end

  def save
    self.class.find(id) ? update : insert
  end
end
