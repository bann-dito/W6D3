# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ApplicationRecord.transaction do
    # Destroy tables (not necessary if using `rails db:seed:replant`)

    ArtworkShare.destroy_all
    Artwork.destroy_all
    User.destroy_all
    
    # Reset primary keys (i.e., ids) 

    %w(users artworks artwork_shares).each do |table_name|
      ApplicationRecord.connection.reset_pk_sequence!(table_name)
    end
  
    # Create seed data
    u1 = User.create!(username: 'Leonardo da Vinci')
    u2 = User.create!(username: 'Vincent van Gogh')
    u3 = User.create!(username: 'Pablo Picasso')
    u4 = User.create!(username: 'Michelangelo')
    a1 = Artwork.create!(title: 'Mona Lisa', image_url: 'art.1.com', artist_id: u1.id)
    a2 = Artwork.create!(title: 'The Starry Night', image_url: 'art.2.com', artist_id: u2.id)
    a3 = Artwork.create!(title: 'La Reve', image_url: 'art.3.com', artist_id: u3.id)
    a4 = Artwork.create!(title: 'Self-Portrait', image_url: 'art.4.com', artist_id: u2.id)
    a5 = Artwork.create!(title: '', image_url: 'art.5.com', artist_id: u2.id)

    ArtworkShare.create!(artwork_id: a1.id, viewer_id: u4.id)
    ArtworkShare.create!(artwork_id: a2.id, viewer_id: u3.id)
    ArtworkShare.create!(artwork_id: a3.id, viewer_id: u1.id)
    ArtworkShare.create!(artwork_id: a4.id, viewer_id: u3.id)
    ArtworkShare.create!(artwork_id: a5.id, viewer_id: u1.id)
    ArtworkShare.create!(artwork_id: a1.id, viewer_id: u2.id)
  
    puts 'Done!'
  end