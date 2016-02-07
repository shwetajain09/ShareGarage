class AddAvatarsToBooks < ActiveRecord::Migration
  def up
    add_attachment :books, :avatar
  end

  def down
    remove_attachment :books, :avatar
  end
end
