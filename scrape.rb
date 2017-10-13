#!/usr/bin/env ruby

require 'httparty'
require 'date'

CURRENT_ETAG = 'CURRENT_ETAG.txt'.freeze
URL = 'https://www.mtbachelor.com/webcams/snowstake.jpg?garbage'.freeze

IO.write(CURRENT_ETAG, 'placeholder') unless File.exist?('CURRENT_ETAG.txt')

last_etag = IO.read(CURRENT_ETAG)
etag      = HTTParty.head(URL).headers['etag']

if last_etag == etag
  puts 'no change.  exiting'
  exit 0
end

IO.write(CURRENT_ETAG, etag)

body = HTTParty.get(URL).response.body

current_date = DateTime.now.strftime('%Y-%M-%d-%H-%M')
file_name = "#{current_date}.jpg"
puts "file change.  saving to #{file_name}"

IO.write(file_name, body)
