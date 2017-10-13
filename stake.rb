#!/usr/bin/env ruby

require 'httparty'
require 'date'

CURRENT_ETAG = 'CURRENT_ETAG.txt'.freeze
URL = 'https://www.mtbachelor.com/webcams/snowstake.jpg?garbage'.freeze

# create a placeholder etag file if one does not exist
IO.write(CURRENT_ETAG, 'placeholder') unless File.exist?('CURRENT_ETAG.txt')

# read the current etag from disk
last_etag = IO.read(CURRENT_ETAG)

# do a http HEAD call, to get current etag
etag      = HTTParty.head(URL).headers['etag']

# compare the etag against the one off disk
if last_etag == etag
  # exit if no change
  puts 'no change.  exiting'
  exit 0
end

# write the new etag to disk
IO.write(CURRENT_ETAG, etag)

# get the full http request
response = HTTParty.get(URL, timeout: 10).response

# exit if not valid request
if response.code != '200'
  puts 'error, non 200'
  exit 1
end

# build a file name
current_date = DateTime.now.strftime('%Y-%m-%d-%H-%M')
file_name = "#{current_date}.jpg"

# tell the people what's up!
puts "file change.  saving to #{file_name}"

# write the file to disk
IO.write(file_name, response.body)
