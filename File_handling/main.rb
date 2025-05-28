require 'colorize'

file_path = "notes.txt"

puts "📓 Welcome to the Notes App!".blue.bold


begin
  if File.exist?(file_path)
    puts "\n📝 Your current notes:".light_green
    puts File.read(file_path)
  else
    puts "\n⚠️ No existing notes found. A new file will be created.".yellow
  end
rescue Errno::EACCES
  puts "🚫 Permission denied when accessing the file.".red
rescue => e
  puts "❌ Error reading the file: #{e.message}".red
end


begin
  print "\nWould you like to add a new note? (y/n): ".light_blue
  answer = gets.chomp.strip.downcase

  if answer == 'y'
    print "✏️ Enter your note: ".light_blue
    new_note = gets.chomp.strip

    begin
      File.open(file_path, "a") do |file|
        file.puts "#{new_note} - #{Time.now.strftime('%Y-%m-%d')}"
      end
      puts "\n✅ Note saved successfully!\n".green
    rescue Errno::EACCES
      puts "🚫 Unable to write to the file. Permission denied.".red
    rescue => e
      puts "❌ Error writing the note: #{e.message}".red
    end
  else
    puts "\n👋 Okay! No changes made.\n".cyan
  end
rescue => e
  puts "❌ Unexpected error during input: #{e.message}".red
end
