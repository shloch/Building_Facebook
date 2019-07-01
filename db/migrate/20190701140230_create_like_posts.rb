class CreateLikePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :like_posts do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
