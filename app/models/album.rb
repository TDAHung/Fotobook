class Album < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :delete_all
  has_many :liking_users, through: :likes, source: :user
  mount_uploaders :album_attachments, PhotoUploader

  validates :is_public, inclusion: { in: [true, false], allow_nil: true }
  validates :title, presence: { message: "Title of album is required" }
  validates :album_attachments, presence: { message: "Album is required"}

  def self.ransackable_attributes(auth_object = nil)
    ["album_attachments", "description", "title", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["likes", "liking_users", "user"]
  end

end
