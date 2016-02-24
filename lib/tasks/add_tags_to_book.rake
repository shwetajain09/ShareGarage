namespace :db do
  desc "Add popular tag to book"
  task :add_popular_tag => :environment do
  	@books = Book.available
  	if @books.count > 10
  		@books = Book.where('title in (?)',['I too had a love story','Adultery','White tiger','The best of me','Train to pakistan','Can love happen twice','The secret','Sherlock Homes','To kill a mocking bird','The payback','The kite runner','The lord of the rings','The Alchemist','Things a little bird told me','Wanderlust'])
  	end
  	@books.each do |book|
  		book.tag_list.add('Popular')
  		book.save
  	end
  end 

    desc "Add indian tag to books"
    task :add_indian_tag => :environment do
      @authors = Author.where('name in (?)',['Chetan Bhagat','Durgesh satpathy','Amish tripathi','Aravind Adiga','Arundhati Roy','Jhumpa Lahiri','Chitra Banerjee Divakaruni','Ashwin Sanghi','Khushwant Singh']).includes(:books)
      @books = @authors.map(&:books).compact.uniq
      @books.each do |book|
         book.each do |b|
          b.tag_list.add('Indian Author')
          b.save
        end   
      end
    end

    desc "Add foreign tag to books"
    task :add_foreign_tag => :environment do
      @authors = Author.where('name in (?)',['Stieg Larsson','Gabriel Garcí­a Márquez','Paulo Coelho','John Green','Dan Brown','Lauren Weisberger','nora roberts','El James','Biz stone','Rhonde Byrne','Nicholas sparks','Jack Canfiled']).includes(:books)
      @books = @authors.map(&:books).compact.uniq
      @books.each do |book|
        book.each do |b|
          b.tag_list.add('Foreign Author')
          b.save
        end        
      end
    end


  
end