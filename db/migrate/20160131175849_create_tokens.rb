class CreateTokens < ActiveRecord::Migration
  def up
    create_table :tokens do |t|
    	t.string :redeem_code
    	t.boolean :is_redeemed , :default => false
    	t.datetime :valid_til
    	t.integer :owner
      t.integer :receiver_id
      t.integer :book_id
    	t.float :credit
      t.timestamps null: false
    end
  end
  def down
    drop_table :tokens
  end
end
