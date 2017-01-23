class UserHealthSystem < ApplicationRecord

	belongs_to :user
	belongs_to :health_system
end
