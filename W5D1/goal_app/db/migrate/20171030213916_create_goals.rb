class CreateGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :goals do |t|
      t.string :title
      t.text :details
      t.integer :user_id
      t.boolean :private
      t.boolean :completed

      t.timestamps
    end
  end
end
