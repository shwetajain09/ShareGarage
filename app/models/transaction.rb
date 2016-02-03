class Transaction < ActiveRecord::Base
	belongs_to :token
	belongs_to :receiver, :class_name => 'User', :foreign_key => :receiver_id 
	belongs_to :giver, :class_name => 'User', :foreign_key => :giver_id
	belongs_to :book
end
