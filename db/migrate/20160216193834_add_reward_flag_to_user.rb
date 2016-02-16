class AddRewardFlagToUser < ActiveRecord::Migration
  def change
  	add_column :users, :got_reward, :boolean, :default => false
  end
end
