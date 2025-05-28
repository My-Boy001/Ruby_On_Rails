loop do
  begin
    puts "Enter your score (0 to 100) or type 'exit' to quit:"
    input = gets.chomp

    break if input.downcase == 'exit'

    if input.match?(/\A\d+\z/)  # Check if input is a number
      score = input.to_i

      if score.between?(0, 100)
        case score
        when 90..100
          puts "🎓 Grade: A"
        when 80..89
          puts "🎉 Grade: B"
        when 70..79
          puts "👍 Grade: C"
        when 60..69
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

  rescue Interrupt
    puts "\nExiting program. Goodbye!"
    break
  rescue StandardError => e
    puts "⚠️ An error occurred: #{e.message}"
  end

  puts
end

puts "Thank you for using the grading system!"
