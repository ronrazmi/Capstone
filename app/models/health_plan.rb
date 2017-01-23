	class HealthPlan < ApplicationRecord
	has_many :users
	has_many :plan_providers
	has_many :providers, through: :plan_providers
	
end
