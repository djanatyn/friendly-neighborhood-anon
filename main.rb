#!/usr/bin/env ruby

# this program will hopefully make people happy
# making people happy is good
# spread the love

require 'rubygems'
require 'headless'
require 'watir-webdriver'

# we need a friendly message to send to the people we care about
abort "#{$0} friendly_message" if (ARGV.size != 1)
friendly_message = ARGV[0]

# these are the people we will send the message to
#
# place the users you want to send messages to in a file called "users"
# separate each user on it's own line
users = File.open('users', 'r') {|f| f.read.split "\n"}
# also let's load the users that were already sent a message today
users_sent = File.open('users_sent', 'r') {|f| f.read.split "\n"}

# if all is good, the friendly anon rises from the depths
headless = Headless.new; headless.start
friendly_anon = Watir::Browser.new

puts "time to brighten up people's day! :)"; puts
puts Time.new
puts "logging in..."

friendly_anon.goto 'http://tumblr.com/login'
friendly_anon.input(:id => 'signup_email').to_subtype.set "user"
friendly_anon.input(:id => 'signup_password').to_subtype.set "pass"
friendly_anon.button(:id => 'signup_forms_submit').click

# okay! we're good
puts "signed in!"

# we can only send 10 messages per hour
messages_sent = 0;

users.each do |user|
  if messages_sent < 10
    if users_sent.include? user
      # let's not send the user two messages in a day!
      puts "#{user} was already sent a message, let's move on"
    else
      # add them to the list of users that were sent messages
      File.open('users_sent', 'a') { |f| f.puts user }

      puts "spreading sunshine to #{user}..."

      friendly_anon.goto "http://www.tumblr.com/ask_form/#{user}.tumblr.com"

      friendly_anon.textarea(:id => "question").value= friendly_message
      friendly_anon.button(:id => "ask_button").click

      puts "#{user}'s day has been brightened!"; puts

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
