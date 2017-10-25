class UpdateUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.remove :name
      t.rename :email, :username
    end

    add_index :users, :username, unique: true
  end
end
