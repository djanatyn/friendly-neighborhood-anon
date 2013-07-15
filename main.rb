#!/usr/bin/env ruby

# this program will hopefully make people happy
# making people happy is good
# spread the love

require 'rubygems'
require 'watir-webdriver'
require 'pp'

# we need a friendly message to send to the people we care about
abort "#{$0} friendly_message" if (ARGV.size != 1)
friendly_message = ARGV[0]

# these are the people we will send the message to
#
# place the users you want to send messages to in a file called "users"
# separate each user on it's own line
users = File.open('users', 'r') {|f| f.read.split "\n"}

# ensure the message being sent is correct
puts "send message \"#{friendly_message}\" to users:"
pp users 

print "> "; q = $stdin.gets

# now quit if the user didn't say yes
abort "okay, you didn't say yes, so i'm out of here!" if (q != "yes\n")

# if all is good, the friendly anon rises from the depths
friendly_anon = Watir::Browser.new :chrome

puts "time to brighten up people's day! :)\n"
users.each do |user|

  puts "spreading sunshine to #{user}..."

  friendly_anon.goto "http://www.tumblr.com/ask_form/#{user}.tumblr.com"

  friendly_anon.textarea(:id => "question").value= friendly_message
  friendly_anon.button(:id => "ask_button").click

  puts "#{user}'s day has been brightened!"
  puts

end

puts "okay, my work here is done!"

# his job complete, the friendly anon goes to sleep
friendly_anon.close
