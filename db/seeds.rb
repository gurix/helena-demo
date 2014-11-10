# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'factory_girl'
require 'ffaker'
require 'database_cleaner'

include FactoryGirl::Syntax::Methods

FactoryGirl.definition_file_paths += ['spec/factories']
FactoryGirl.find_definitions

puts 'Cleaning database ...'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

Dir[File.dirname(__FILE__) + '/seeds/**/*.rb'].each {|file| require file }

Seeds::User.generate_data
Seeds::Survey.generate_data
