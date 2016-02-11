class CreateJoinTableBooksUserLocation < ActiveRecord::Migration
  def up
    create_join_table :books_users, :locations do |t|
      t.belongs_to :books_user, index: true
      t.belongs_to :location, index: true
    end
    add_index :books_users_locations, [ :books_user_id, :location_id ], :unique => true, :name => 'by_books_user_and_location'

  end
  def down 
  	drop_table :books_users_locations
  end

end
