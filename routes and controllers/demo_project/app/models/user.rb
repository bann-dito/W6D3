# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true

    has_many :artworks,
        foreign_key: :artist_id,
        class_name: :Artwork,
        dependent: :destroy

    has_many :artworks_viewed,
        foreign_key: :viewer_id,
        class_name: :ArtworkShare,
        dependent: :destroy

    has_many :shared_artworks,
        through: :artworks_viewed,
        source: :artwork

    has_many :comments,
    foreign_key: :author_id,
    class_name: :Comment,
    dependent: :destroy

    # def self.search_for_user_id(params) #/users/G
    #     User
    #         .select('*')
    #         .joins(:shared_viewers)
    #         .where('artist_id = (?) OR viewer_id = (?)', user_id, user_id)
    # end
end
