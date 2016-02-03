# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
Language.destroy_all
languages = Language.create([{ title: 'English' ,:locale => "en"}, { title: 'Hindi' ,:locale => "hn"}])
Location.destroy_all
Location.create([{ name: 'Dwarka'},{ name: 'All delhi/Ncr'},{name: 'Janakpuri'},{name: 'Yamuna Vihar'}])
#   Mayor.create(name: 'Emanuel', city: cities.first)
