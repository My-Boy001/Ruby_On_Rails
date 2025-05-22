loop do
  puts "Enter your score (0 to 100)"
  input = gets.chomp


  if input.match?(/\A\d+\z/)
    score = input.to_i
    if score.between?(0, 100)
      if score >= 90
        puts "🎓 Grade: A"
      elsif score >= 80
        puts "🎉 Grade: B"
      elsif score >= 70
        puts "👍 Grade: C"
      elsif score >= 60
        puts "😐 Grade: D"
      else
        puts "❌ Grade: F"
      end
    else
      puts "⚠️ Please enter a score between 0 and 100."
    end
  else
    puts "⚠️ Invalid input. Please enter a numeric value."
  end

  puts  
end

puts "Thank you for using the grading system!"
