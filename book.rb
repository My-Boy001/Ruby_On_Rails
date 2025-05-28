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

begin
  puts "\nWould you like to add your own book? (yes/no)"
  answer = gets.chomp.downcase
rescue Interrupt
  puts "\nInput interrupted. Exiting..."
  exit
rescue => e
  puts "Error reading input: #{e.message}"
  exit
end

if answer == "yes"
  begin
    print "\nEnter book title: "
    user_title = gets.chomp

    print "Enter author name: "
    user_author = gets.chomp

    print "Enter year of publication: "
    user_year_input = gets.chomp
    user_year = Integer(user_year_input) rescue nil

    if user_year.nil? || user_year <= 0
      raise ArgumentError, "Year must be a positive integer."
    end

    user_book = Book.new(user_title, user_author, user_year)
    books << user_book

  rescue Interrupt
    puts "\nInput interrupted. Exiting..."
    exit
  rescue ArgumentError => e
    puts "Invalid input: #{e.message}"
    puts "Book not added."
  rescue => e
    puts "An error occurred: #{e.message}"
  end
end

puts "\n📚 Book Summaries:"
books.each_with_index do |book, index|
  puts "#{index + 1}. #{book.summary}"
end
