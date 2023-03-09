class CreateCreateArtworkShares < ActiveRecord::Migration[7.0]
  def change

    add_index :artworks, [:artist_id, :title], unique: true

    create_table :artwork_shares do |t|
      t.references :artwork, null: false, foreign_key: :true
      t.references :viewer, null: false, foreign_key: {to_table: :users}
      t.timestamps
    end

  end
end
