require_relative 'contact'
require_relative 'contact_database'
 
# TODO: Implement command line interaction
# This should be the only file where you use puts and gets



user_input = ARGV[0]
user_search = ARGV[1]

def help()

  puts "new - Create a new contact"
  puts "list - List all contacts"
  puts "show - Show a contact"
  puts "find - Find a contact"

end

case user_input

when "help"
  help()
when "new"
  puts "Please enter contact name"
  name = STDIN.gets.chomp()
  puts "Please enter contact email address"
  email = STDIN.gets.chomp()
  contact = Contact.create(name, email)
when "list"
  Contact.all()
when "show"
  ok = false
  id = 0
  while !ok
    puts "Enter employee number.."
    begin
      id = Integer(STDIN.gets.chomp())
      ok = true
      Contact.show(id)
    rescue
      puts "Enter a valid integer"
    end
  end
when "find"
  Contact.find(user_search)

end

