class CreateBookRequests < ActiveRecord::Migration
  def change
    create_table :book_requests do |t|
    	t.references :user
    	t.references :book
      t.timestamps null: false
    end
  end
end
