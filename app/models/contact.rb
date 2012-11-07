class Contact < ActiveRecord::Base
	belongs_to :user
	attr_accessible :first_name, :last_name, :phone
end
