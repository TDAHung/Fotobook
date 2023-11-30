class Follower < ApplicationRecord
  belongs_to :follower, class_name: 'User', foreign_key: 'follower_id'
  belongs_to :following_user, class_name: 'User', foreign_key: 'following_user_id'
end
