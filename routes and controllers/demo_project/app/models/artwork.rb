# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :string
#  image_url  :string           not null
#  artist_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artwork < ApplicationRecord
    validates :image_url, presence: true, uniqueness: true
    validates :artist_id, presence: true, uniqueness:{scope: :title}

    belongs_to :artist,
        foreign_key: :artist_id,
        class_name: :User

    has_many :artworks_shared,
        foreign_key: :artwork_id,
        class_name: :ArtworkShare

    has_many :shared_viewers,
        through: :artworks_shared,
        source: :viewer

    has_many :comments,
    foreign_key: :artwork_id,
    class_name: :Comment,
    dependent: :destroy

    def self.artworks_for_user_id(user_id) #SELECT * from artworks WHERE artist_id = 'id' AND shared_viewers
        Artwork
            .select('*')
            .joins(:shared_viewers)
            .where('artist_id = (?) OR viewer_id = (?)', user_id, user_id)
    end
end
