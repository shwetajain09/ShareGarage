class CreateBooks < ActiveRecord::Migration
  def up
    create_table :books do |t|
    	t.string :title
    	t.string :subtitle
    	t.string :link
    	t.text :description
    	t.text :json_details
    	t.string :publisher
    	t.date :published_date
    	t.string :isbn
    	t.integer :page_count
    	t.references :language
    	t.integer :count
      t.timestamps null: false
    end
    add_index :books, :title
    add_index :books, :subtitle
    add_index :books, :publisher
    add_index :books, :isbn
    add_index :books, :language_id
  end

  def down
  	drop_table :books
  end
end
