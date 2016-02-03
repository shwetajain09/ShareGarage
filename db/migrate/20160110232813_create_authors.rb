class CreateAuthors < ActiveRecord::Migration
  def up
    create_table :authors do |t|
    	t.string :name
    	t.text :json_details
      t.timestamps null: false
    end
    add_index :authors, :name
  end

  def down
  	drop_table :authors
  end
end
