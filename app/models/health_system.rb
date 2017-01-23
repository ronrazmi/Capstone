class HealthSystem < ApplicationRecord
	has_many :user_health_systems
	has_many :users, through: :user_health_systems
	has_many :providers

	geocoded_by :address
	after_validation :geocode
end
