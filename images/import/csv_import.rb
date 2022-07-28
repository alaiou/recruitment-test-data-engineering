#!/usr/bin/env ruby

require 'active_record'
require 'csv'

class Person < ActiveRecord::Base
  self.table_name = "people"

  belongs_to :place
end

class Place < ActiveRecord::Base
  has_many :people
end

ActiveRecord::Base.establish_connection(adapter: :mysql2, host: :database, username: :codetest, password: :swordfish, database: :codetest)

ActiveRecord::Base.connection.truncate_tables(:people, :places) if (ActiveRecord::Base.connection.table_exists? 'people') && (ActiveRecord::Base.connection.table_exists? 'places') 

CSV.read('/data/places.csv', headers: true).map(&:to_h).each do |row|
  Place.create(row)
end

CSV.read('/data/people.csv', headers: true).map(&:to_h).each do |row|
  place = Place.find_by(city: row["place_of_birth"])
  person = Person.create(row)
  person.place = place
  person.save!
end
