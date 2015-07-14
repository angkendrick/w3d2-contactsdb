require_relative 'contact'
require_relative 'database_engine'

class ContactApp

  def self.create_a_contact
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

  def self.retrieve_all_contacts
    db = Database.new
    contact_results = db.return_all_contacts # retrieve all contacts
    contact_results.each { |x| x.to_s }
    nil
  end

  def self.destroy(id) # delete a contact by id
    db = Database.new
    db.delete_a_contact(id)
  end

  def self.destroy_agent # sets up the destroy method
    puts "enter id number"
    id = gets.chomp()
    ContactApp.destroy(id)
  end

  def self.find_contact(type, string) # type = id / first / last / email
    db = Database.new
    contact_results = db.find_contact(type, string)
    contact_results.each { |x| x.to_s }
    nil
  end

  def self.find_contact_agent # sets up the find_contact method
    puts "id / first / last / email"
    type = gets.chomp()
    puts "enter search string"
    string = gets.chomp()

    ContactApp.find_contact(type, string)
  end

  def main_menu
    puts "create / show / find / delete"
    case gets.chomp().downcase
    when 'create'
      ContactApp.create_a_contact
    when 'show'
      ContactApp.retrieve_all_contacts
    when 'find'
      ContactApp.find_contact_agent
    when 'delete'
      ContactApp.destroy_agent
    end
  end

end