## TODO: Implement CSV reading/writing

require 'csv'

class Database

  def get_index() #provides index by counting existing number of lines in csv
    csv_file = File.open("contacts.csv", "r")
    csv_file.readlines.size + 1 #count number of lines and use as index
  end

  def write_contact(contact_instance, id) #write a contact to the csv
    ok_to_write = true
    csv_file = File.open("contacts.csv", "r")
    while !csv_file.eof?
      line = csv_file.readline #read each line
      if line.match("#{contact_instance.name}") && line.match("#{contact_instance.email}")
        puts "Contact: #{contact_instance.name} already exists with the same email address: #{contact_instance.email}"
        ok_to_write = false
      end
    end
    if ok_to_write
      phone_numbers = add_phone_numbers() #get phone numbers here
      begin
        csv_writer = File.open("contacts.csv", "a") #write contact to csv file
        csv_writer.puts "#{id}, #{contact_instance.name}, #{contact_instance.email},#{phone_numbers}"
        csv_writer.close
        puts "Contact Saved! Contact ##{id}"
      rescue
        "Failed to write to contacts.csv"
      end
    end
  end

  def add_phone_numbers() #add phone numbers and returns a string, currentyl used inside #write_contact
    cont_adding = true
    phone_numbers = ""
    puts "Would you like to add a Phone number? (y/n)"
    if STDIN.gets.chomp().downcase == 'y'
      puts 'input using this format: "Mobile : XXX-XXX-XXXX" or "Home : XXX-XXX-XXXX"'
      while cont_adding
        puts "Enter phone number.."
        number = STDIN.gets.chomp()
        phone_numbers << " #{number} |"
        puts "add more?"
        if STDIN.gets.chomp().downcase == 'n'
          cont_adding = false
        end
      end
      return phone_numbers
    end
  end

  def read_all_contacts() #display all contacts from the csv
    count = 0
    csv_file = File.open("contacts.csv", "r")
      while !csv_file.eof?
        line = csv_file.readline #read each line
        array = line.split(%r{,\s*}) #store each line into array
        array.map! { |x| x.chomp } #remove newline char from each element
        puts "#{array[0]}: #{array[1]} (#{array[2]})"
        count += 1
      end
      puts "---"
      puts "#{count} records total"
  end

  def show_contact(id) #find a specific contact using the ID #
    array = []
    not_found = false
    csv_file = File.open("contacts.csv", "r")
      while !csv_file.eof?
        line = csv_file.readline #read each line
        array << line.split(%r{,\s*}) #store each line into array
      end
      array.each do |x| #remove \n from multidimensional array
        x.each do |y|
          y.chomp!
        end
      end
      array.each do |x| #fully populated array.. search for ID on [0]
        if x[0].to_i == id
          puts "ID:     #{x[0]}"
          puts "Name:   #{x[1]}"
          puts "Email:  #{x[2]}"
          not_found = false
          break
        else
          not_found = true
        end
      end
      if not_found then puts "Contact not found!" end
  end

  def search_contact(term) #search per line on csv using regex and display line per match
    csv_file = File.open("contacts.csv", "r")
    puts "search term: #{term}"
    while !csv_file.eof?
      line = csv_file.readline #read each line
      if line.match("#{term}")
        puts line
      end
    end
  end

end
