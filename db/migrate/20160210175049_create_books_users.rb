class CreateBooksUsers < ActiveRecord::Migration
  def change
    create_table :books_users do |t|
    	t.references :book
    	t.references :user
      t.boolean :is_provided
      t.integer :count, :default => 1
      t.timestamps null: false
    end
  end
end
