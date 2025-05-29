def greet_users
  yield("Alice")
  yield("Bob")
end

greet_users { |name| puts "Hello, #{name}!" }

[1, 2, 3, 4, 5, 6].each do |num|
  puts num if num.even?
end

say_hello = Proc.new { |name| puts "Hello from Proc, #{name}!" }
say_hello.call("Charlie")

lenient_proc = Proc.new { |x, y| puts "Proc: x=#{x}, y=#{y}" }
lenient_proc.call(10)

multiply = ->(x, y) { x * y }
puts "5 * 3 = #{multiply.call(5, 3)}"

strict_lambda = ->(x, y) { puts "Lambda: x=#{x}, y=#{y}" }

begin
  strict_lambda.call(10)
rescue ArgumentError => e
  puts "Lambda error: #{e.message}"
end

def lambda_example
  result = -> { return "Returned from lambda" }.call
  return "After lambda: #{result}"
end

puts lambda_example

squares = [1, 2, 3, 4].map { |n| n**2 }
puts squares.inspect

evens = [1, 2, 3, 4, 5, 6].select { |n| n.even? }
puts evens.inspect

sum = [1, 2, 3, 4].reduce(0) { |acc, n| acc + n }
puts "Sum = #{sum}"
