require_relative 'contact'
require_relative 'database_engine'

class ContactApp

  def create_a_contact
    puts "First Name"
    first_name = gets.chomp()
    puts "Last Name"
    last_name = gets.chomp()
    puts "Email"
    email = gets.chomp()

    hash = { "first_name" => first_name, 
              "last_name" => last_name,
              "email" => email
            }

    contact = Contact.new(hash) #contact information packed into a contact object
    db = Database.new
    db.write_a_contact(contact)

  end

  def display_all_contacts
    db = Database.new
    contact_results = db.return_all_contacts #retrieve all contacts
    contact_results.each do |contact|
      puts contact.first_name
      puts contact.last_name
      puts contact.email
    end
  end

end