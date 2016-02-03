class AddCounterTokenInUser < ActiveRecord::Migration
  def change
  	add_column :users, :tokens_count, :integer, :default => 0
  end
end
