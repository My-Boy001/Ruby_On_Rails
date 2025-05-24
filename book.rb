# book.rb

class Book
  attr_accessor :title, :author, :year

  def initialize(title, author, year)
    @title = title
    @author = author
    @year = year
  end

  def summary
    "#{title} by #{author}, published in #{year}."
  end
end

books = [
  Book.new("The Great Gatsby", "F. Scott Fitzgerald", 1925),
  Book.new("To Kill a Mockingbird", "Harper Lee", 1960),
  Book.new("1984", "George Orwell", 1949)
]

puts "\nWould you like to add your own book? (yes/no)"
answer = gets.chomp.downcase

if answer == "yes"
  print "\nEnter book title: "
  user_title = gets.chomp

  print "Enter author name: "
  user_author = gets.chomp

  print "Enter year of publication: "
  user_year = gets.chomp.to_i

  user_book = Book.new(user_title, user_author, user_year)
  books << user_book
end

puts "\n📚 Book Summaries:"
books.each_with_index do |book, index|
  puts "#{index + 1}. #{book.summary}"
end
