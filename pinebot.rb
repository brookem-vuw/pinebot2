require 'discordrb'
require 'google_drive'
require_relative 'quote_module'
require_relative 'characters'


bot = Discordrb::Commands::CommandBot.new token: 'Mzg2Mzk5NTY1MDIyMjMyNTc2.DRxnpA.r480IIQmfLa6YYZKKEmf_RvHyg8', prefix: '~'
@search = Characters.new


bot.command :user do |event|
  event.user.name
end

bot.command(:random, min_args: 0, max_args: 2, description: 'Generates a random number between 0 and 1, 0 and max or min and max.', usage: 'random [min/max] [max]') do |_event, min, max|
  if max
    rand(min.to_i..max.to_i)
  elsif min
    rand(0..min.to_i)
  else
    rand
  end
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

bot.command :character do |_event, *args|
  @search.find(args)
end

bot.message(content: 'Ping!') do |event|
  m = event.respond('Pong!')
  m.edit "Pong! Time taken: #{Time.now - event.timestamp} seconds."
end

bot.command(:exit, help_available: false) do |event|
  break unless event.user.id == 98308488941309952 # Replace number with your ID
  bot.send_message(event.channel.id, 'dead now.')
  exit
end

bot.run
