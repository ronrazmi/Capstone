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
	validates :email, presence: true
	validates :email, uniqueness: true
	validates :password, length: {minimum: 6}
	
	geocoded_by :address
	after_validation :geocode


def risk
	
	risk_score = 0
	if age > 55
		risk_score += 2
	end
	if diagnoses.count >= 2
		risk_score += 2
	end
	if medications.count >= 2
		risk_score += 2
	end
	diagnoses.each do |diagnosis|
		
		if diagnosis.ICD_code == "E11" || diagnosis.ICD_code == "414.01" || diagnosis.ICD_code == "401.1" || diagnosis.ICD_code == "034.0"
		risk_score += 4
		end
	end	

	
	return risk_score	 	
end

def uti_risk

	risk_score = 0
	if age > 65
		risk_score += 2
	end
	if diagnoses.count >= 2
		risk_score += 2
	end
	if medications.count >= 2
		risk_score += 2
	end
	diagnoses.each do |diagnosis|
		if diagnosis.ICD_code == "079.98"
		risk_score += 4
		end
	end

	return risk_score
end

end
			
			
			
