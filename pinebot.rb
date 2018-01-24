require 'discordrb'
require 'google_drive'
require_relative 'quote_module'
require_relative 'characters'


bot = Discordrb::Commands::CommandBot.new token: 'Mzg2Mzk5NTY1MDIyMjMyNTc2.DRxnpA.r480IIQmfLa6YYZKKEmf_RvHyg8', prefix: '~'

@search = Characters.new
@quotelog = QuoteModule.new

bot.command :user do |event|
  event.user.name
end

bot.command :wiki do |_event|
  'https://www.reddit.com/r/SupersRP/wiki/index'
end

bot.command :tiers do |_event|
  'https://www.reddit.com/r/SupersRP/wiki/tiers'
end

bot.command :charactercreation do |_event|
  'https://www.reddit.com/r/SupersRP/wiki/charactercreation'
end

bot.command :template do |event|
  template = File.readlines('template.txt').join(' ')
  event.user.pm('```' + template + '```')
end

bot.command :power do |_event|
  'http://powerlisting.wikia.com/wiki/special:random'
end

bot.command :character do |_event, *args|
  @search.find(args)
end

bot.command :aq do |_event, *args|
  # break unless event.user.roles.include?(3)
  user = args[0]
  quote = args[1..args.size].join(' ')
  @quotelog.add_quote(user, quote)
  puts 'added quote to ' + user.to_s
end

bot.command :decide do |_event, *args|
  choices = []
  choice = []
  args.each do |arg|
    if arg == 'or'
      choices.push(choice.join(' '))
      choice = []
    else
      choice.push(arg)
    end
  end
  choices.push(choice.join(' '))
  choices.sample
end

bot.command :q do |event, *args|
  user = args[0]
  if !@quotelog.find_user(user)
    bot.send_message(event.channel.id, 'no quotes for ' + user.to_s + '. adding user...')
    @quotelog.add_user(user)
  else
    @quotelog.find_quote(user) + ' - ' + user
  end
end

bot.command :quotes do |event|
  break unless event.user.id == 98308488941309952
  # @quotelog.masterlist
end

bot.message(content: 'Ping!') do |event|
  m = event.respond('Pong!')
  m.edit "Pong! Time taken: #{Time.now - event.timestamp} seconds."
end

bot.message(content: 'PINEBOT') do |event|
  event.respond('what?')
end

bot.command(:exit, help_available: false) do |event|
  break unless event.user.id == 98308488941309952 # Replace number with your ID
  bot.send_message(event.channel.id, 'dead now.')
  exit
end

bot.run
