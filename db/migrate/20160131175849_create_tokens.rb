class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
    	t.string :redeem_code
    	t.boolean :is_redeemed , :default => false
    	t.datetime :valid_til
    	t.integer :provider
      t.timestamps null: false
    end
  end
end
