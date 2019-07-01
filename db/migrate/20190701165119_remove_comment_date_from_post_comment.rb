class RemoveCommentDateFromPostComment < ActiveRecord::Migration[5.2]
  def change
    remove_column :post_comments, :comment_date
  end
end
