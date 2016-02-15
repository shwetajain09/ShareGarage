class AddSlugTo < ActiveRecord::Migration
  def change
  	add_column  :users, :slug,:string
  	add_column :books, :slug,  :string
  end
end
