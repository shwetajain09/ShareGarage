class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
    	t.references :user
    	t.float :rating
    	t.float :credit, :default => 0.0
    	t.references :location
      t.timestamps null: false
    end
  end
end
