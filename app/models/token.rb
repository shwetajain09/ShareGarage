class Token < ActiveRecord::Base
	belongs_to :user,:class_name => 'User',:foreign_key => :provider, :counter_cache => true
	has_one :debit_transaction,:class_name => 'Transaction',:foreign_key => :transaction_id
end
