class CreateFollows < ActiveRecord::Migration[7.0]
  def up
    create_table :followers,id: false do |t|
      t.references :follower, null: false, foreign_key: { to_table: :users }
      t.references :following_user, null:false, foreign_key: { to_table: :users }

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          CREATE UNIQUE INDEX unique_follower_following_user_index
          ON followers (follower_id, following_user_id)
        SQL
      end

      dir.down do
        execute <<-SQL
          DROP INDEX IF EXISTS unique_follower_following_user_index
        SQL
      end
    end
  end


  def down
    drop_table :followers
  end
end
