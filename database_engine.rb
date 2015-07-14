require 'pg'
require_relative 'contact'

class Database

  def connection #create a PG connection to heroku
    PG.connect(
      host: 'ec2-54-197-238-19.compute-1.amazonaws.com',
      dbname: 'dfsofepbaf97gv',
      user: 'smedpfnjsymgdd',
      password: 'bx4jbrw68K-IZhHlMi9KgvdalD'
      )
  end

  def write_a_contact(contact)
    sql = 'INSERT INTO contacts (first_name, last_name, email) VALUES ($1, $2, $3)'
    begin
      self.connection.exec_params(sql, [contact.first_name, contact.last_name, contact.email]) #write to the db
      puts "Write OK!"
    rescue
      "Error writing to the database"
    end
  end

  def return_all_contacts
    self.connection.exec('SELECT * FROM contacts;') do |results|
      results.map do |hash|
        Contact.new(hash)
      end
    end
  end


end