# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
Language.destroy_all
languages = Language.create([{ title: 'English' ,:locale => "en"}, { title: 'Hindi' ,:locale => "hn"}])
Location.destroy_all
delhi_parent = Location.create(name: 'All Delhi/Ncr')

#North Delhi
Location.create([{name: 'Delhi University', parent_id: delhi_parent.id},{ name: 'Kashmere Gate', parent_id: delhi_parent.id},{name: 'Kamla Nagar', parent_id: delhi_parent.id},{name: 'Kohat Enclave', parent_id: delhi_parent.id},{name: 'Adarsh Nagar', parent_id: delhi_parent.id},{name: 'Rohini', parent_id: delhi_parent.id}])
# West Dellhi
Location.create([{name: 'Pitampura', parent_id: delhi_parent.id},{ name: 'Netaji Subhash Place', parent_id: delhi_parent.id},{name: 'Keshave Puram', parent_id: delhi_parent.id},{name: 'Inderlok', parent_id: delhi_parent.id}])
#South Delhi
Location.create([{name: 'Shastri Nagar', parent_id: delhi_parent.id},{ name: 'Dwarka', parent_id: delhi_parent.id},{name: 'Janakpuri', parent_id: delhi_parent.id},{name: 'Shahdra', parent_id: delhi_parent.id}])
# East Delhi
Location.create([{name: 'Mansarovar Park', parent_id: delhi_parent.id},{ name: 'Dilshad Garden', parent_id: delhi_parent.id},{name: 'Jahangir Puri', parent_id: delhi_parent.id},{name: 'Azadpur', parent_id: delhi_parent.id}])

Location.create([{name: 'Civil Lines', parent_id: delhi_parent.id},{ name: 'Chandni Chowk', parent_id: delhi_parent.id},{name: 'Connaught Place', parent_id: delhi_parent.id},{name: 'Central Secretariat', parent_id: delhi_parent.id}])

Location.create([{name: 'AIMS', parent_id: delhi_parent.id},{ name: 'Green Park', parent_id: delhi_parent.id},{name: 'Hauz khas', parent_id: delhi_parent.id},{name: 'Saket', parent_id: delhi_parent.id}])

Location.create([{name: 'Faridabad', parent_id: delhi_parent.id},{ name: 'Uttam Nagar', parent_id: delhi_parent.id},{name: 'Subhash Nagar', parent_id: delhi_parent.id},{name: 'Rajouri', parent_id: delhi_parent.id}])

Location.create([{name: 'Kirti Nagar', parent_id: delhi_parent.id},{ name: 'Karol Bagh', parent_id: delhi_parent.id},{name: 'Mandi House', parent_id: delhi_parent.id},{name: 'Laxmi Nagar', parent_id: delhi_parent.id}])

Location.create([{name: 'Kaushambi', parent_id: delhi_parent.id},{ name: 'Karkardoma', parent_id: delhi_parent.id},{name: 'Vaishali', parent_id: delhi_parent.id},{name: 'Akshardham', parent_id: delhi_parent.id}])

Location.create([{name: 'Mayur Vihar', parent_id: delhi_parent.id},{ name: 'Anand Vihar', parent_id: delhi_parent.id},{name: 'Noida', parent_id: delhi_parent.id},{name: 'Gurgoan', parent_id: delhi_parent.id}])

Location.create([{name: 'Khan Market', parent_id: delhi_parent.id},{ name: 'Moolchand', parent_id: delhi_parent.id},{name: 'Nehru Place', parent_id: delhi_parent.id},{name: 'Okhla', parent_id: delhi_parent.id}])

Location.create([{name: 'Dhaula Kuan', parent_id: delhi_parent.id},{ name: 'Mundka', parent_id: delhi_parent.id},{name: 'Udhyog Nagar', parent_id: delhi_parent.id},{name: 'Paschim Vihar', parent_id: delhi_parent.id}])

Location.create([{name: 'Gaziabad', parent_id: delhi_parent.id},{ name: 'Kundi', parent_id: delhi_parent.id},{name: 'Chhattarpur', parent_id: delhi_parent.id},{name: 'Lajpat Nagar', parent_id: delhi_parent.id}])
