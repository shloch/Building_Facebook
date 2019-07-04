class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
        add_column :users, :date_of_birth, :datetime
	 add_column :users, :gender, :string
	 add_column :users, :mobile, :string
  end
end
