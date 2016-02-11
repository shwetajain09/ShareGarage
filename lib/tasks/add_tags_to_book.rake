namespace :db do
  desc "Add tags to book"
  task :add_tags_to_book => :environment do
  	@books = Book.available
  	if @books.count > 10
  		@books = Book.where('title in (?)',['half girlfriend','Adultery','White tiger','The best of me','Train to pakistan','Dongri to Dubai','The secret'])
  	end
  	@books.each do |book|
  		book.tag_list.add('Popular')
  		book.save
  	end
  end 
end