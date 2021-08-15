class AddNameToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :uid, :string
    add_column :users, :name, :string
    add_column :users, :avatar, :string
    add_column :users, :provider, :string
    
  end
end
