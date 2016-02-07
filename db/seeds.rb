# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
Language.destroy_all
languages = Language.create([{ title: 'English' ,:locale => "en"}, { title: 'Hindi' ,:locale => "hn"}])
Location.destroy_all
parent_loc = Location.create(name: 'All delhi/Ncr')
Location.create([{ name: 'Dwarka', parent_id: parent_loc.id},{name: 'Janakpuri', parent_id: parent_loc.id},{name: 'Yamuna Vihar', parent_id: parent_loc.id}])
#   Mayor.create(name: 'Emanuel', city: cities.first)
