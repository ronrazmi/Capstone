class User < ApplicationRecord
	has_secure_password
	has_many :user_diagnoses
	has_many :diagnoses,  through: :user_diagnoses
	has_many :user_medications
	has_many :medications, through: :user_medications
	has_many :user_health_systems
	has_many :health_systems, through: :user_health_systems
	has_many :user_providers
	has_many :providers, through: :user_providers
	belongs_to :health_plan
	
	geocoded_by :address
	after_validation :geocode


def risk
	
	risk_score = 0
	if age > 55
		risk_score += 2
	elsif diagnoses.count >= 2
		risk_score += 2
	elsif medications.count >= 2
		risk_score += 2
	elsif diagnosis.ICD_code == "E11" || diagnosis.ICD_code == "414.01" || diagnosis.ICD_code == "401.1" || diagnosis.ICD_code == "034.0"
		risk_score += 4
	end

	# if risk_score >= 5
	# 	return "high_risk"
	# elsif risk_score >= 3 && risk_score < 5
	# 	return "moderate_risk"
	# else risk_score < 3
	# 	return "low_risk"
	# end

	return risk_score	 	
end


end
			
			
			
