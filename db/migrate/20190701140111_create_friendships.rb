class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.text  :status, :default => "pending"
      
      t.timestamps
    end
    add_reference :friendships , :inviting , references: :inviting_friend, index: true, foreign_key: true
    add_reference :friendships , :invited , references: :invited_friend, index: true, foreign_key: true
    
  end
end
