#!/usr/bin/env ruby

# this program will hopefully make people happy
# making people happy is good
# spread the love

require 'rubygems'
require 'mechanize'

anon = Mechanize.new { |robot|
    robot.user_agent_alias = 'Mac Safari'
    robot.follow_meta_refresh = true
}

page = anon.get 'http://www.tumblr.com/ask_form/zubkoland.tumblr.com'

page.form.field_with(:name => 'post[one]').value= "hello this is a test!"

page.form.submit
