#!/usr/bin/env ruby
puts Time.new

# this program will hopefully make people happy
# making people happy is good
# spread the love

require 'rubygems'
require 'headless'
require 'watir-webdriver'
require 'logger'

logger = Logger.new('log')

logger.formatter = proc do |severity, datetime, progname, msg|
  "#{datetime}: #{msg}\n"
end

# we need a friendly message to send to the people we care about
abort "#{$0} username password friendly_message" if (ARGV.size != 3)
username, password, friendly_message = ARGV

logger.debug { 'checking for users to send message to' }
# place the users you want to send messages to in a file called "users"
# separate each user on it's own line
users = File.open('users', 'r') {|f| f.read.split "\n"}
# also let's load the users that were already sent a message today
users_sent = File.open('users_sent', 'r') {|f| f.read.split "\n"}

# double check that not all users have been messaged
if users.all? {|user| users_sent.include? user}
  logger.debug { 'all users have been sent a message, exiting' }
  abort "all users have been messaged, have a nice day!"
end

logger.debug { 'users available, continuing' }
logger.debug { "sending message \"#{friendly_message}\"" }
# if all is good, the friendly anon rises from the depths
headless = Headless.new; headless.start

friendly_anon = Watir::Browser.new
logger.debug { 'started browser' }

puts "time to brighten up people's day! :)"; puts
puts "logging in..."

friendly_anon.goto 'http://tumblr.com/login'
friendly_anon.input(:id => 'signup_email').to_subtype.set username
friendly_anon.input(:id => 'signup_password').to_subtype.set password
friendly_anon.button(:id => 'signup_forms_submit').click

# okay! we're good
puts "signed in!"
logger.debug { 'logged in' }

# we can only send 10 messages per hour
messages_sent = 0;

users.each do |user|
  if messages_sent < 10
    if users_sent.include? user
      # let's not send the user two messages in a day!
      puts "#{user} was already sent a message, let's move on"
    else
      puts "spreading sunshine to #{user}..."

      friendly_anon.goto "http://www.tumblr.com/ask_form/#{user}.tumblr.com"

      friendly_anon.textarea(:id => "question").value= friendly_message
      friendly_anon.button(:id => "ask_button").click

      puts "#{user}'s day has been brightened!"; puts
      # add them to the list of users that were sent messages
      File.open('users_sent', 'a') { |f| f.puts user }
      logger.debug { "message sent to #{user}" }

     # and another message sent!
      messages_sent += 1
    end
  end
end

puts "okay, my work here is done!"

# his job complete, the friendly anon goes to sleep
friendly_anon.close
# and the loyal X session companion also rests
headless.close
logger.debug { 'done' }
