require 'colorize'

file_path = "notes.txt"

puts "📓 Welcome to the Notes App!".blue.bold

if File.exist?(file_path)
  puts "\n📝 Your current notes:".light_green
  puts File.read(file_path)
else
  puts "\n⚠️ No existing notes found. A new file will be created.".yellow
end

print "\nWould you like to add a new note? (y/n): ".light_blue
answer = gets.chomp.strip.downcase

if answer == 'y'
  print "✏️ Enter your note: ".light_blue
  new_note = gets.chomp.strip

  File.open(file_path, "a") do |file|
    file.puts "#{new_note} - #{Time.now.strftime('%Y-%m-%d')}"
  end

  puts "\n✅ Note saved successfully!\n".green
else
  puts "\n👋 Okay! No changes made.\n".cyan
end
