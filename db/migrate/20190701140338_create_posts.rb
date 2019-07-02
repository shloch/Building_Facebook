class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :post_text
      t.datetime :date
      t.references :author, index: true, foreign_key: { to_table: :users } 

      t.timestamps
    end
  end

end
