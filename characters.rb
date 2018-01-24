require 'google_drive'
require 'byebug'

#character list
class Characters
  def initialize
    session = GoogleDrive::Session.from_config("config.json")
    @list = session.spreadsheet_by_key("1nB9d4KpnpgvIUm63JyOJ3YR2BNG92yx6KTho9CeoI5I").worksheets[0]
    reload
  end

  def keys
    puts 'generating keys...'
    key_list = []
    (2..@list.num_rows).each do |row|
      key_list.push(@list[row, 1])
    end
    key_list
  end

  def find(search)
    reload

    puts "searching for #{search}..."
    req = search.join(' ')
    names = keys.map(&:downcase)

    out = []
    names.map do |name|
      if name.include?(req.downcase)
        name_key = names.index(name) + 2
        out.push(@list[name_key, 2])
      end
    end
    if out.empty?
      'no character sheet logged for ' + req + ', try checking the sheet: https://docs.google.com/spreadsheets/d/1nB9d4KpnpgvIUm63JyOJ3YR2BNG92yx6KTho9CeoI5I/edit?usp=sharing'
    else
      out.join(' ')
    end
  end

  def reload
    @list.reload
  end
end

Characters.new
