class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :first_name
    	t.string :last_name
    	t.integer :phone_no, :limit => 8
    	t.string :gender, :limit => 1
      t.timestamps null: false
    end
  end
end
