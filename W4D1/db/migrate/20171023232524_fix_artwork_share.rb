class FixArtworkShare < ActiveRecord::Migration[5.1]
  def change
    change_table :artwork_shares do |t|
      t.integer :artwork_id, null: false
      t.integer :viewer_id, null: false
    end

    add_index :artwork_shares, [:artwork_id, :viewer_id]
  end
end
