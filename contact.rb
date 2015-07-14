require_relative 'database_engine'

class Contact
 
  attr_accessor :first_name, :last_name, :email
 

  def initialize(hash)
    # TODO: assign local variables to instance variables
    @id = hash["id"].to_i if hash["id"]
    @first_name = hash["first_name"]
    @last_name = hash["last_name"]
    @email = hash["email"]
  end

  def to_s
    puts "#{@id} - #{@first_name}, #{@last_name} - #{@email}"
  end

end