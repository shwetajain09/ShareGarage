class CreateJoinTableBooksUserLocation < ActiveRecord::Migration
  def change
    create_join_table :books_users, :locations do |t|
      t.index [:books_user_id, :location_id]
      t.index [:location_id, :books_user_id]
    end
  end
end
