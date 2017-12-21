require 'discordrb'
require 'google_drive'
require_relative 'quote_module'
require_relative 'characters'

# Here we instantiate a `CommandBot` instead of a regular `Bot`, which has the functionality to add commands using the
# `command` method. We have to set a `prefix` here, which will be the character that triggers command execution.
bot = Discordrb::Commands::CommandBot.new token: 'Mzg2Mzk5NTY1MDIyMjMyNTc2.DRxnpA.r480IIQmfLa6YYZKKEmf_RvHyg8', prefix: '~'

bot.command :user do |event|
  # Commands send whatever is returned from the block to the channel. This allows for compact commands like this,
  # but you have to be aware of this so you don't accidentally return something you didn't intend to.
  # To prevent the return value to be sent to the channel, you can just return `nil`.
  event.user.name
end

bot.command(:random, min_args: 0, max_args: 2, description: 'Generates a random number between 0 and 1, 0 and max or min and max.', usage: 'random [min/max] [max]') do |_event, min, max|
  # The `if` statement returns one of multiple different things based on the condition. Its return value
  # is then returned from the block and sent to the channel
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

bot.message(content: 'Ping!') do |event|
  # The `respond` method returns a `Message` object, which is stored in a variable `m`. The `edit` method is then called
  # to edit the message with the time difference between when the event was received and after the message was sent.
  m = event.respond('Pong!')
  m.edit "Pong! Time taken: #{Time.now - event.timestamp} seconds."
end

bot.run
