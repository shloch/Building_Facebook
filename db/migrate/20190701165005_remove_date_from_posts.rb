class RemoveDateFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :date 
  end
end
