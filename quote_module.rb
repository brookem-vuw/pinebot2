
class QuoteModule
  def find_user
  end

  def find_quote
  end

  def new_user(name)
    File.open('quotes.txt', 'a') do |line|
      line.puts '\r' + 'user: ' + name
    end
  end

  def new_quote
  end
end
