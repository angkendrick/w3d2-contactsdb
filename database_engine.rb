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

  def write_a_contact(contact) #uses a Contact Object
    sql = 'INSERT INTO contacts (first_name, last_name, email) VALUES ($1, $2, $3)'
    begin
      self.connection.exec_params(sql, [contact.first_name, contact.last_name, contact.email]) #write to the db
      puts "Write OK!"
    rescue
      "Error writing to the database"
    end
  end

  def return_all_contacts
    self.connection.exec('SELECT * FROM contacts;') do |results| # punch results into a Contact Object
      results.map do |hash|
        Contact.new(hash)
      end
    end
  end

  def delete_a_contact(id)
    sql = 'DELETE FROM contacts WHERE id = $1'
    begin
      self.connection.exec_params(sql, [id])
    rescue
      puts "Error deleting from database"
    end
  end

  def find_contact(type, string)
    case type
    when 'id'
      string = string.to_i
      sql = 'SELECT * FROM contacts WHERE id = $1'
    when 'first'
      sql = 'SELECT * FROM contacts WHERE first_name = $1'
    when 'last'
      sql = 'SELECT * FROM contacts WHERE last_name = $1'
    when 'email'
      sql = 'SELECT * FROM contacts WHERE email = $1'
    end

    self.connection.exec_params(sql, [string]) do |results| # punch all results into a Contact Object
      results.map do |hash|
        Contact.new(hash)
      end
    end

  end


end