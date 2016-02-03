class AddCountToBookUser < ActiveRecord::Migration
  def change
  	add_column :books_users, :count, :integer,:default => 1
  end
end
