puts "Enter your score:"
score = gets.chomp.to_i  

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
