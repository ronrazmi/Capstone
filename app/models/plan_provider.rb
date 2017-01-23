class PlanProvider < ApplicationRecord
	belongs_to :health_plan
	belongs_to :provider
end
