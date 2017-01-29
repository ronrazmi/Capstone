class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:benefits, :show, :question_one, :acs, :uti]

	def new
		render 'new.html.erb'
	end

	def benefits
		@user = current_user
		render 'benefits.html.erb'
	end

	def home
		render 'home.html.erb'

	end

	def show

		render 'show.html.erb'
	end


	def edit
		@user = User.find_by(health_plan_id: params[:health_plan_id])
		render 'edit.html.erb'

	end

	def update
		user = User.find_by(health_plan_id: params[:health_plan_id])
		user.update(first_name: params["first_name"],last_name: params["last_name"], address: params["address"], phone_number: params["phone_number"], email: params["email"], health_plan_id: params["health_plan_id"], password: params["password"], password_confirmation: params["password_confirmation"], active: true)
		if user.save
			session[:user_id] = user.id
			# flash[:success] = "You Successfully Registered"
			redirect_to '/triage'
		else
			# flash[:danger]= "Login was not created"
		
		render 'new.html.erb'
		end
	end

	

	def question_one
		@user = current_user
		if params[:symptom][:symptom_name] == "burning with urination"
			render "uti.html.erb"
		elsif params[:symptom][:symptom_name] == "chest pain" || "shortness of breath"
			render "acs.html.erb"
		
		end
	end




	def acs
		@user = current_user
		baseline_risk_score = @user.risk
		p baseline_risk_score
		if params[:duration][:duration_length].to_i < 2
			baseline_risk_score += 1
		elsif params[:duration][:duration_length].to_i > 2 && params[:duration][:duration_length].to_i  < 6
			baseline_risk_score += 2	
		end

		intermediate_risk_score = baseline_risk_score                
		if params[:severity][:severity_intensity].to_i > 1 && params[:severity][:severity_intensity].to_i < 3
			intermediate_risk_score += 4
		elsif params[:severity][:severity_intensity].to_i > 3 && params[:severity][:severity_intensity].to_i < 6
			intermediate_risk_score += 6
		elsif params[:severity][:severity_intensity].to_i > 6 && params[:severity][:severity_intensity].to_i < 10
			intermediate_risk_score += 8
		elsif params[:severity][:severity_intensity].to_i >= 10
			intermediate_risk_score += 10
		end

		@final_risk_score = intermediate_risk_score
		if params[:history] == 'Yes' && params[:heart_related] == 'Yes'
			@final_risk_score += 10
		end
		if params[:shortness_of_breath] == 'Yes'
			@final_risk_score += 2
		end
		if params[:sweating] == 'Yes'
			@final_risk_score += 2
		end
		if params[:weakness_dizziness] == 'Yes'
			@final_risk_score += 2
		end			
		# return @final_risk_score

		if @final_risk_score >= 25
			@risk_level = "High"
		elsif @final_risk_score >= 15 && @final_risk_score < 25
			@risk_level = "Medium"
		elsif @final_risk_score < 15
			@risk_level = "low"
		end

		if @final_risk_score >= 25
		 	@care_setting = HealthSystem.where(er: true)
		 	 @care_place = "ER"
		 	 @care_type = ['er']
		 elsif @final_risk_score >= 15 && @final_risk_score < 25
		 	@care_setting = HealthSystem.where(er: true) || HealthSystem.where(urgent_care: true)
		 	@care_place = "Emergency Room or urgent Care"
		 	@care_type = ['er', 'urgent_care']

		 elsif @final_risk_score < 15
		 	@care_setting = HealthSystem.where(pharmacy_clinic: true) || HealthSystem.where(walk_in_clinic: true) || HealthSystem.where(virtual_visit: true)
		 	@care_place = "Pharmacy Clinic, Physician Clinic or Virtual Visit"
		 	@care_type = ['virtual_visit', 'pharmacy_clinic', 'walk_in_clinic']
		 end
		 base_distance = 100
		 @closest_distance = 0
		 @closest_care_setting = 0
		 @care_setting.each do |care_setting|
			distance = Geocoder::Calculations.distance_between([@user.latitude, @user.longitude],[care_setting.latitude, care_setting.longitude])
			if distance < base_distance
			 base_distance = distance.to_f.round(1)
			@closest_care_setting = care_setting
			@closest_distance = base_distance
			end 
		end
			@liabilities = {}
		@care_type.each do |type|
			
			if type == 'er'
				@liabilities['er'] =
				 {'outpatient_copay' => 0, 
				  'estimated_service_charge' => 0,
				  'estimated_total_out_of_pocket_expenses_including_deductibles' => 0}
				outpatient_copay = @user.health_plan.er
				estimated_service_charge = 1500 * @user.health_plan.co_insurance
				if @user.out_of_pocket_max < @user.health_plan.out_of_pocket_max	
					if @user.deductible <= @user.health_plan.deductible
						estimated_total_out_of_pocket_expenses_including_deductibles = (@user.health_plan.deductible - @user.deductible) + outpatient_copay + estimated_service_charge 
					elsif @user.deductible > @user.health_plan.deductible
						estimated_total_out_of_pocket_expenses_including_deductibles = 
					out_patient_copay + estimated_service_charge 
					end
				else estimated_service_charge = 0
					outpatient_copay = 0
					estimated_total_out_of_pocket_expenses_including_deductibles = 0
				end 
				@liabilities['er']['outpatient_copay'] = outpatient_copay
				@liabilities['er']['estimated_service_charge'] = estimated_service_charge
				@liabilities['er']['estimated_total_out_of_pocket_expenses_including_deductibles'] = estimated_total_out_of_pocket_expenses_including_deductibles
				elsif type == 'urgent_care'
					@liabilities['urgent_care'] =
				 {'outpatient_copay' => 0, 
				  'estimated_service_charge' => 0,
				  'estimated_total_out_of_pocket_expenses_including_deductibles' => 0}
				  outpatient_copay = @user.health_plan.urgent_care
				  estimated_service_charge = 500 * @user.health_plan.co_insurance
				  if @user.out_of_pocket_max < @user.health_plan.out_of_pocket_max	
						if @user.deductible <= @user.health_plan.deductible
						estimated_total_out_of_pocket_expenses_including_deductibles = (@user.health_plan.deductible - @user.deductible) + outpatient_copay + estimated_service_charge 
						elsif @user.deductible > @user.health_plan.deductible
						estimated_total_out_of_pocket_expenses_including_deductibles = 
					out_patient_copay + estimated_service_charge 
					end
					else estimated_service_charge = 0
					outpatient_copay = 0
					estimated_total_out_of_pocket_expenses_including_deductibles = 0
					end 
					@liabilities['urgent_care']['outpatient_copay'] = outpatient_copay
				@liabilities['urgent_care']['estimated_service_charge'] = estimated_service_charge
				@liabilities['urgent_care']['estimated_total_out_of_pocket_expenses_including_deductibles'] = estimated_total_out_of_pocket_expenses_including_deductibles
			elsif type == 'pharmacy_clinic'
					@liabilities['pharmacy_clinic'] =
				 {'outpatient_copay' => 0, 
				  'estimated_service_charge' => 0,
				  'estimated_total_out_of_pocket_expenses_including_deductibles' => 0}
				  outpatient_copay = @user.health_plan.pharmacy_clinic
				  estimated_service_charge = 200 * @user.health_plan.co_insurance
				  if @user.out_of_pocket_max < @user.health_plan.out_of_pocket_max	
						if @user.deductible <= @user.health_plan.deductible
						estimated_total_out_of_pocket_expenses_including_deductibles = (@user.health_plan.deductible - @user.deductible) + outpatient_copay + estimated_service_charge 
						elsif @user.deductible > @user.health_plan.deductible
						estimated_total_out_of_pocket_expenses_including_deductibles = 
					out_patient_copay + estimated_service_charge 
					end
					else estimated_service_charge = 0
					outpatient_copay = 0
					estimated_total_out_of_pocket_expenses_including_deductibles = 0
					end 
					@liabilities['pharmacy_clinic']['outpatient_copay'] = outpatient_copay
				@liabilities['pharmacy_clinic']['estimated_service_charge'] = estimated_service_charge
				@liabilities['pharmacy_clinic']['estimated_total_out_of_pocket_expenses_including_deductibles'] = estimated_total_out_of_pocket_expenses_including_deductibles
				elsif type == 'virtual_visit'
					@liabilities['virtual_visit'] =
				 {'outpatient_copay' => 0, 
				  'estimated_service_charge' => 0,
				  'estimated_total_out_of_pocket_expenses_including_deductibles' => 0}
				  outpatient_copay = @user.health_plan.virtual_visit
				  estimated_service_charge = 50 * @user.health_plan.co_insurance
				  if @user.out_of_pocket_max < @user.health_plan.out_of_pocket_max	
						if @user.deductible <= @user.health_plan.deductible
						estimated_total_out_of_pocket_expenses_including_deductibles = (@user.health_plan.deductible - @user.deductible) + outpatient_copay + estimated_service_charge 
						elsif @user.deductible > @user.health_plan.deductible
						estimated_total_out_of_pocket_expenses_including_deductibles = 
					out_patient_copay + estimated_service_charge 
					end
					else estimated_service_charge = 0
					outpatient_copay = 0
					estimated_total_out_of_pocket_expenses_including_deductibles = 0
					end 
					@liabilities['virtual_visit']['outpatient_copay'] = outpatient_copay
				@liabilities['virtual_visit']['estimated_service_charge'] = estimated_service_charge
				@liabilities['virtual_visit']['estimated_total_out_of_pocket_expenses_including_deductibles'] = estimated_total_out_of_pocket_expenses_including_deductibles
			elsif type == 'walk_in_clinic'
					@liabilities['walk_in_clinic'] =
				 {'outpatient_copay' => 0, 
				  'estimated_service_charge' => 0,
				  'estimated_total_out_of_pocket_expenses_including_deductibles' => 0}
				  outpatient_copay = @user.health_plan.pcp
				  estimated_service_charge = 100 * @user.health_plan.co_insurance
				  if @user.out_of_pocket_max < @user.health_plan.out_of_pocket_max	
						if @user.deductible <= @user.health_plan.deductible
						estimated_total_out_of_pocket_expenses_including_deductibles = (@user.health_plan.deductible - @user.deductible) + outpatient_copay + estimated_service_charge 
						elsif @user.deductible > @user.health_plan.deductible
						estimated_total_out_of_pocket_expenses_including_deductibles = 
					out_patient_copay + estimated_service_charge 
					end
					else estimated_service_charge = 0
					outpatient_copay = 0
					estimated_total_out_of_pocket_expenses_including_deductibles = 0
					end 
					@liabilities['walk_in_clinic']['outpatient_copay'] = outpatient_copay
				@liabilities['walk_in_clinic']['estimated_service_charge'] = estimated_service_charge
				@liabilities['walk_in_clinic']['estimated_total_out_of_pocket_expenses_including_deductibles'] = estimated_total_out_of_pocket_expenses_including_deductibles
			end
	

		end
	

		render 'acstriage.html.erb'
	end

	def uti

		@user = current_user
		baseline_risk_score = @user.uti_risk
		if params[:duration][:duration_length].to_i < 2
			baseline_risk_score += 1
		elsif params[:duration][:duration_length].to_i > 2 && params[:duration][:duration_length].to_i  < 6
			baseline_risk_score += 2
		end

		intermediate_risk_score = baseline_risk_score                
		if params[:severity][:severity_intensity].to_i > 1 && params[:severity][:severity_intensity].to_i < 3
			intermediate_risk_score += 2
		elsif params[:severity][:severity_intensity].to_i > 3 && params[:severity][:severity_intensity].to_i < 6
			intermediate_risk_score += 4
		elsif params[:severity][:severity_intensity].to_i > 6 && params[:severity][:severity_intensity].to_i < 10
			intermediate_risk_score += 6
		elsif params[:severity][:severity_intensity].to_i >= 10
			intermediate_risk_score += 10
		end

		@final_risk_score = intermediate_risk_score
		if params[:history] == 'Yes' && params[:uti_related] == 'Yes'
			@final_risk_score += 4
		end
		if params[:std_related] == 'Yes'
			@final_risk_score += 6
		end

		if params[:urine_blood] == 'Yes'
			@final_risk_score += 2
		end
		if params[:fevers] == 'Yes'
			@final_risk_score += 2
		end
		if params[:sweating_chills] == 'Yes'
			@final_risk_score += 2
		end			
		# return @final_risk_score

		if @final_risk_score >= 25
			@risk_level = "High"
		elsif @final_risk_score >= 15 && @final_risk_score < 25
			@risk_level = "Medium"
		elsif @final_risk_score < 15
			@risk_level = "low"
		end

		if @final_risk_score >= 25
		 	@care_setting = HealthSystem.where(er: true)
		 	 @care_place = "ER"
		 	 @care_type = ['er']
		 elsif @final_risk_score >= 15 && @final_risk_score < 25
		 	@care_setting = HealthSystem.where(er: true) || HealthSystem.where(urgent_care: true)
		 	@care_place = "Emergency Room or urgent Care"
		 	@care_type = ['er', 'urgent_care']

		 elsif @final_risk_score < 15
		 	@care_setting = HealthSystem.where(pharmacy_clinic: true) || HealthSystem.where(walk_in_clinic: true) || HealthSystem.where(virtual_visit: true)
		 	@care_place = "Pharmacy Clinic, Physician Clinic or Virtual Visit"
		 	@care_type = ['virtual_visit', 'pharmacy_clinic', 'walk_in_clinic']
		 end
		 base_distance = 100
		 @closest_distance = 0
		 @closest_care_setting = 0
		 @care_setting.each do |care_setting|
			distance = Geocoder::Calculations.distance_between([@user.latitude, @user.longitude],[care_setting.latitude, care_setting.longitude])
			if distance < base_distance
			 base_distance = distance.to_f.round(1)
			@closest_care_setting = care_setting
			@closest_distance = base_distance
			end
		end
		
			@liabilities = {}
		@care_type.each do |type|
			
			if type == 'er'
				@liabilities['er'] =
				 {'outpatient_copay' => 0, 
				  'estimated_service_charge' => 0,
				  'estimated_total_out_of_pocket_expenses_including_deductibles' => 0}
				outpatient_copay = @user.health_plan.er
				estimated_service_charge = 750 * @user.health_plan.co_insurance
				if @user.out_of_pocket_max < @user.health_plan.out_of_pocket_max	
					if @user.deductible <= @user.health_plan.deductible
						estimated_total_out_of_pocket_expenses_including_deductibles = (@user.health_plan.deductible - @user.deductible) + outpatient_copay + estimated_service_charge 
					elsif @user.deductible > @user.health_plan.deductible
						estimated_total_out_of_pocket_expenses_including_deductibles = 
					out_patient_copay + estimated_service_charge 
					end
				else estimated_service_charge = 0
					outpatient_copay = 0
					estimated_total_out_of_pocket_expenses_including_deductibles = 0
				end 
				@liabilities['er']['outpatient_copay'] = outpatient_copay
				@liabilities['er']['estimated_service_charge'] = estimated_service_charge
				@liabilities['er']['estimated_total_out_of_pocket_expenses_including_deductibles'] = estimated_total_out_of_pocket_expenses_including_deductibles
				elsif type == 'urgent_care'
					@liabilities['urgent_care'] =
				 {'outpatient_copay' => 0, 
				  'estimated_service_charge' => 0,
				  'estimated_total_out_of_pocket_expenses_including_deductibles' => 0}
				  outpatient_copay = @user.health_plan.urgent_care
				  estimated_service_charge = 200 * @user.health_plan.co_insurance
				  if @user.out_of_pocket_max < @user.health_plan.out_of_pocket_max	
						if @user.deductible <= @user.health_plan.deductible
						estimated_total_out_of_pocket_expenses_including_deductibles = (@user.health_plan.deductible - @user.deductible) + outpatient_copay + estimated_service_charge 
						elsif @user.deductible > @user.health_plan.deductible
						estimated_total_out_of_pocket_expenses_including_deductibles = 
					out_patient_copay + estimated_service_charge 
					end
					else estimated_service_charge = 0
					outpatient_copay = 0
					estimated_total_out_of_pocket_expenses_including_deductibles = 0
					end 
					@liabilities['urgent_care']['outpatient_copay'] = outpatient_copay
				@liabilities['urgent_care']['estimated_service_charge'] = estimated_service_charge
				@liabilities['urgent_care']['estimated_total_out_of_pocket_expenses_including_deductibles'] = estimated_total_out_of_pocket_expenses_including_deductibles
			elsif type == 'pharmacy_clinic'
					@liabilities['pharmacy_clinic'] =
				 {'outpatient_copay' => 0, 
				  'estimated_service_charge' => 0,
				  'estimated_total_out_of_pocket_expenses_including_deductibles' => 0}
				  outpatient_copay = @user.health_plan.pharmacy_clinic
				  estimated_service_charge = 100 * @user.health_plan.co_insurance
				  if @user.out_of_pocket_max < @user.health_plan.out_of_pocket_max	
						if @user.deductible <= @user.health_plan.deductible
						estimated_total_out_of_pocket_expenses_including_deductibles = (@user.health_plan.deductible - @user.deductible) + outpatient_copay + estimated_service_charge 
						elsif @user.deductible > @user.health_plan.deductible
						estimated_total_out_of_pocket_expenses_including_deductibles = 
					out_patient_copay + estimated_service_charge 
					end
					else estimated_service_charge = 0
					outpatient_copay = 0
					estimated_total_out_of_pocket_expenses_including_deductibles = 0
					end 
					@liabilities['pharmacy_clinic']['outpatient_copay'] = outpatient_copay
				@liabilities['pharmacy_clinic']['estimated_service_charge'] = estimated_service_charge
				@liabilities['pharmacy_clinic']['estimated_total_out_of_pocket_expenses_including_deductibles'] = estimated_total_out_of_pocket_expenses_including_deductibles
				elsif type == 'virtual_visit'
					@liabilities['virtual_visit'] =
				 {'outpatient_copay' => 0, 
				  'estimated_service_charge' => 0,
				  'estimated_total_out_of_pocket_expenses_including_deductibles' => 0}
				  outpatient_copay = @user.health_plan.virtual_visit
				  estimated_service_charge = 50 * @user.health_plan.co_insurance
				  if @user.out_of_pocket_max < @user.health_plan.out_of_pocket_max	
						if @user.deductible <= @user.health_plan.deductible
						estimated_total_out_of_pocket_expenses_including_deductibles = (@user.health_plan.deductible - @user.deductible) + outpatient_copay + estimated_service_charge 
						elsif @user.deductible > @user.health_plan.deductible
						estimated_total_out_of_pocket_expenses_including_deductibles = 
					out_patient_copay + estimated_service_charge 
					end
					else estimated_service_charge = 0
					outpatient_copay = 0
					estimated_total_out_of_pocket_expenses_including_deductibles = 0
					end 
					@liabilities['virtual_visit']['outpatient_copay'] = outpatient_copay
				@liabilities['virtual_visit']['estimated_service_charge'] = estimated_service_charge
				@liabilities['virtual_visit']['estimated_total_out_of_pocket_expenses_including_deductibles'] = estimated_total_out_of_pocket_expenses_including_deductibles
			elsif type == 'walk_in_clinic'
					@liabilities['walk_in_clinic'] =
				 {'outpatient_copay' => 0, 
				  'estimated_service_charge' => 0,
				  'estimated_total_out_of_pocket_expenses_including_deductibles' => 0}
				  outpatient_copay = @user.health_plan.pcp
				  estimated_service_charge = 100 * @user.health_plan.co_insurance
				  if @user.out_of_pocket_max < @user.health_plan.out_of_pocket_max	
						if @user.deductible <= @user.health_plan.deductible
						estimated_total_out_of_pocket_expenses_including_deductibles = (@user.health_plan.deductible - @user.deductible) + outpatient_copay + estimated_service_charge 
						elsif @user.deductible > @user.health_plan.deductible
						estimated_total_out_of_pocket_expenses_including_deductibles = 
					out_patient_copay + estimated_service_charge 
					end
					else estimated_service_charge = 0
					outpatient_copay = 0
					estimated_total_out_of_pocket_expenses_including_deductibles = 0
					end 
					@liabilities['walk_in_clinic']['outpatient_copay'] = outpatient_copay
				@liabilities['walk_in_clinic']['estimated_service_charge'] = estimated_service_charge
				@liabilities['walk_in_clinic']['estimated_total_out_of_pocket_expenses_including_deductibles'] = estimated_total_out_of_pocket_expenses_including_deductibles
			end
		end





		render 'utitriage.html.erb'
	end

	

end
