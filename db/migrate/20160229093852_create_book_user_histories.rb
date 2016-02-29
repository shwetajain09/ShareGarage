class CreateBookUserHistories < ActiveRecord::Migration
  def change
    create_table :book_user_histories do |t|
    	t.integer :book_id
    	t.integer :user_id
    	t.string :location
      t.timestamps null: false
    end
  end
end
