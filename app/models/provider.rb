class Provider < ApplicationRecord
	has_many :user_providers
	has_many :users, through: :user_providers
	belongs_to :health_system

	geocoded_by :address
	after_validation :geocode
	
end
