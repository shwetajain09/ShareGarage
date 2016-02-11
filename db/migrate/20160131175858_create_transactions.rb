class CreateTransactions < ActiveRecord::Migration
  def up
    create_table :transactions do |t|
    	t.references :book
    	t.integer :receiver_id
    	t.integer :giver_id
    	t.references :token
    	t.boolean :is_donated, :default => false
      t.string :message
      t.float :credit, :default => 0.0
      t.timestamps null: false
    end
  end
  def down
    drop_table :transactions
  end
end
