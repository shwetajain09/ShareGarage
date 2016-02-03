class CreateLanguages < ActiveRecord::Migration
  def up
    create_table :languages do |t|
    	t.string :title
    	t.string :country_name
    	t.string :locale
      t.timestamps null: false
    end
  end

  def down
  	drop_table :languages
  end
end
