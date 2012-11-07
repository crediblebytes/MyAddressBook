# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

puts 'SETTING UP LOGIN'
user = User.create! :name => 'User', :email => 'user@gmail.com', :password => 'userpass', :password_confirmation => 'userpass'
puts 'New user created: ' << user.name << ' Password: ' << user.password
admin = User.create! :name => 'Admin', :email => 'admin@gmail.com', :password => 'adminpass', :password_confirmation => 'adminpass'
admin.toggle!(:admin)
puts 'New user created: ' << admin.name << ' Password: ' << admin.password
