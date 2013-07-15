#!/usr/bin/env ruby

# this program will hopefully make people happy
# making people happy is good
# spread the love

require 'rubygems'
require 'mechanize'

anon = Mechanize.new { |robot|
    robot.user_agent_alias = 'Mac Safari'
}

anon.get 'http://zubkoland.tumblr.com/ask'
