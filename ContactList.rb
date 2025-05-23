
contacts = [
  { name: "Alice Johnson", phones: ["123-456-7890", "987-654-3210"], email: "alice@example.com" },
  { name: "Bob Smith", phones: ["555-555-5555"], email: "bob@example.com" },
  { name: "Charlie Brown", phones: ["111-222-3333"], email: "charlie@example.com" }
]

puts "All Contacts:"
contacts.each do |contact|
  puts "Name: #{contact[:name]}"
  puts "Phones: #{contact[:phones].join(', ')}"
  puts "Email: #{contact[:email]}"
  puts "---"
end
names = contacts.map { |c| c[:name] }
puts "Contact Names: #{names.join(', ')}"

multiple_phones = contacts.select { |c| c[:phones].length > 1 }
puts "Contacts with multiple phone numbers:"
multiple_phones.each { |c| puts c[:name] }


