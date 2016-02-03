class Author < ActiveRecord::Base
	has_and_belongs_to_many :books, :uniq => true, :read_only => true
end
