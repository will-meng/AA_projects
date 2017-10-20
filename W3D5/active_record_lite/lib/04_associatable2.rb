require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    # Cat::has_one_through(:home, :human, :house)
    through_options = assoc_options[through_name] #=> human_options

    define_method(name) do
      # through_options.model_class #=> Human
      source_options = through_options.model_class.assoc_options[source_name]

      source_table = source_options.table_name
      through_table = through_options.table_name

      foreign_key_val = send(through_options.foreign_key)

      results = DBConnection.execute(<<-SQL, foreign_key_val)
        SELECT
          #{source_table}.*
        FROM
          #{through_table}
        JOIN
          #{source_table} ON #{through_table}.#{source_options.foreign_key} =
          #{source_table}.#{source_options.primary_key}
        WHERE
          #{through_table}.#{through_options.primary_key} = ?
      SQL

      return nil if results.empty?
      source_options.model_class.new(results.first)
    end
  end
end
