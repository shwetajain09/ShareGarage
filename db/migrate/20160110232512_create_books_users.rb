class CreateBooksUsers < ActiveRecord::Migration
  def up
    create_table :books_users do |t|
    	t.references :book
    	t.references :user
      t.boolean :is_provided
      t.timestamps null: false
    end
    add_index :books_users, :is_provided
  end
  def down
  	drop_table :books_users
  end

end
