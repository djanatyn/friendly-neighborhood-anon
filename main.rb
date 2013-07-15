#!/usr/bin/env ruby

# this program will hopefully make people happy
# making people happy is good
# spread the love

require 'rubygems'
require 'watir-webdriver'

# we need a friendly message to send to the people we care about
abort "#{$0} friendly_message" if (ARGV.size != 1)
friendly_message = ARGV[0]

# these are the people we will send the message to
users = ['zubkoland']

# the friendly anon rises from the depths
friendly_anon = Watir::Browser.new :ff

users.each { |user|

  puts "spreading sunshine to #{user}..."

  friendly_anon.goto "http://www.tumblr.com/ask_form/#{user}.tumblr.com"

  friendly_anon.textarea(:id => "question").value= friendly_message
  friendly_anon.button(:id => "ask_button").click

  puts "#{user}'s day has been brightened!"
  puts

}

# his job complete, the friendly anon goes to sleep
friendly_anon.close
