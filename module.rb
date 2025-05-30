module Flyable
  def fly
    puts "I can fly!"
  end
end

class Bird
  include Flyable
end

class Plane
  include Flyable
end

bird = Bird.new
bird.fly   

plane = Plane.new
plane.fly   


module Animals
  class Dog
    def speak
      puts "Woof!"
    end
  end

  class Cat
    def speak
      puts "Meow!"
    end
  end
end

dog = Animals::Dog.new
dog.speak   

cat = Animals::Cat.new
cat.speak   
