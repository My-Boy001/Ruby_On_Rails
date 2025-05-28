require 'pry'

def greet_user(name)

  binding.pry  
  
  puts "Hello, #{name}!"
end

greet_user("Alice")
