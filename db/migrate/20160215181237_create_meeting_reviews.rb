class CreateMeetingReviews < ActiveRecord::Migration
  def change
    create_table :meeting_reviews do |t|
    	t.integer :reviewer_id
    	t.integer :reviewee_id
    	t.integer :book_id
    	t.date :meeting_date
    	t.float :rating
    	t.text :review
      t.timestamps null: false
    end
  end
end
