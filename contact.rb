require_relative 'database_engine'

class Contact
 
  #attr_accessor :name, :email
 
  def initialize(first_name, last_name, email)
    # TODO: assign local variables to instance variables
    @id
    @first_name = first_name
    @last_name = last_name
    @email = email

  end
 
  def to_s
    # TODO: return string representation of Contact
  end
 
  ## Class Methods
  class << self
    def create(name, email)
      # TODO: Will initialize a contact as well as add it to the list of contacts
      @contact = Contact.new(name, email) #initialize contact
      db = Database.new()
      id = db.get_index() #count number of lines and use as index
      db.write_contact(@contact, id) #write contact to csv file
    end
 
    def find(term)
      # TODO: Will find and return contacts that contain the term in the first name, last name or email
      db = Database.new()
      db.search_contact(term)
    end
 
    def all
      # TODO: Return the list of contacts, as is
      db = Database.new()
      db.read_all_contacts()
    end
    
    def show(id)
      # TODO: Show a contact, based on ID
      db = Database.new()
      db.show_contact(id)
    end
    
  end
 
end