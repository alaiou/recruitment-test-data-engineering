#!/usr/bin/env ruby

require 'active_record'
require 'json'

ActiveRecord::Base.establish_connection(adapter: :mysql2, host: :database, username: :codetest, password: :swordfish, database: :codetest)

query_data = ActiveRecord::Base.connection.execute("SELECT places.country AS country, COUNT(people.id) AS people_sum FROM people JOIN places ON people.place_id = places.id GROUP BY places.country;")

json_data = query_data.to_h.to_json
File.delete('/data/summary_output.json') if File.exist?('/data/summary_output.json')

File.write('/data/summary_output.json', json_data)
