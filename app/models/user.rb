class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :albums, dependent: :destroy, dependent: :delete_all
  has_many :photos, dependent: :destroy, dependent: :delete_all

  has_many :followers, foreign_key: 'follower_id', dependent: :delete_all
  has_many :followees,  foreign_key: 'following_user_id', dependent: :delete_all, class_name: 'Follower'

  has_many :likes, dependent: :delete_all
  has_many :liked_albums, through: :likes, source: :likeable, class_name: 'Album'
  has_many :liked_photos, through: :likes, source: :likeable, class_name: 'Photo'

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/}
  validates :first_name, presence: true
  mount_uploader :img_url, AvatarUploader
  enum user_type: { guest: 0, user: 1, admin: 2 }

  def self.ransackable_attributes(auth_object = nil)
    ["email", "first_name", "last_name"]
  end


end
