class Photo < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :delete_all
  has_many :liking_users, through: :likes, source: :user

  mount_uploader :img_url, PhotoUploader

  validates :img_url, presence: {message: "Photo is required"}
  validates :title, presence: {message: "Title is required"}
  validates :is_public, inclusion: { in: [true, false], allow_nil: true }

  def self.ransackable_attributes(auth_object = nil)
    ["description", "title", "user_id"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["likes", "liking_users", "user"]
  end
end
