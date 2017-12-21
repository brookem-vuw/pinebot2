require 'google_drive'

#character list
class Characters
  def initialize
    session = GoogleDrive::Session.from_config("config.json")
    @list = session.spreadsheet_by_key("1nB9d4KpnpgvIUm63JyOJ3YR2BNG92yx6KTho9CeoI5I").worksheets[0]
    find('Glass')
  end

  def keys
    puts "hi"
    key_list = []
    (2..@list.num_cols).each do |row|
      key_list.push(@list[row, 1])
    end
    key_list
  end

  def find(search)
    names = keys
    names.map { |name|
      if name.include?(search)
        name_key = names.index(name) + 2
        puts @list[name_key, 2]
      end
    }
  end
end

Characters.new
