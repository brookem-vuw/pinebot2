require 'byebug'

class QuoteModule
  def initialize
    read_quotes
  end

  def read_quotes
    @masterlist = []
    @quotes = []
    File.open('quotes.txt', 'r').each do |line|
      # byebug
      if line.include?('user: ')
        @masterlist.push(@quotes) unless @quotes.empty?
        @quotes = []
        line.slice!('user: ')
      end
      @quotes.push(line.chomp)
    end
  end

  def write_quotes
    quotelog = File.open('quotes.txt', 'w')
    @masterlist.each do |list|
      list.each do |line|
        if line == list[0]
          quotelog.puts('user: ' + line)
        else
          quotelog.puts(line)
        end
      end
    end
    quotelog.puts('user: ')
  end

  def find_user(name)
    user = ''
    @masterlist.each do |list|
      if list[0].downcase == name.downcase
        user = name
        @quotes = list
        puts 'found ' + name
      end
    end
    return user != ''
  end

  def find_quote(name)
    find_user(name)
    @quotes[1..@quotes.size].sample
  end

  def add_user(name)
    @masterlist.push([name])
  end

  def add_quote(name, quote)
    find_user(name)
    @quotes.push(quote)
    write_quotes
  end

  def masterlist
    @masterlist
  end
end

QuoteModule.new
