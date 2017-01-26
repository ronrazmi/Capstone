# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create(first_name: "Jake", last_name: "Laporte", date_of_birth: "08/02/1976", age: 40, address: "22 Nob Hill ln, Charlotte, NC 23432", phone_number: "917-801-6753", email: "jake@yahoo.com")

# HealthPlan.create([
# 	{name: "United_Select", deductible: 1000, virtual_visit: 25, pcp: 30, specialist: 50, er: 250, urgent_care: 100, co_insurance: 0.15, out_of_pocket_max: 3000, inpatient_deductible: 500, pharmacy_clinic: 25},
# 	{name: "United_Select_plus", deductible: 500, virtual_visit: 20, pcp: 25, specialist: 40, er: 250, urgent_care: 75, co_insurance: 0.10, out_of_pocket_max: 2500, inpatient_deductible: 500, pharmacy_clinic: 20},
# 	{name: "United_Select_premium", deductible: 250, virtual_visit: 15, pcp: 20, specialist: 30, er: 200, urgent_care: 50, co_insurance: 0.10, out_of_pocket_max: 2000, inpatient_deductible: 500, pharmacy_clinic: 15},
# 	{name: "Blue_Cross_Select", deductible: 1500, virtual_visit: 40, pcp: 50, specialist: 100, er: 300, urgent_care: 150, co_insurance: 0.20, out_of_pocket_max: 4000, inpatient_deductible: 500, pharmacy_clinic: 40},
# 	{name: "Blue_Cross_Select_plus", deductible: 1000, virtual_visit: 30, pcp: 40, specialist: 75, er: 250, urgent_care: 100, co_insurance: 0.15, out_of_pocket_max: 3000, inpatient_deductible: 500, pharmacy_clinic: 30}
# 	])


# User.create([
# 	{first_name: "Gerry", last_name: "Petratos", date_of_birth: "08/02/1952", age: 66, address: "829 W 181st St, New York, NY 10033", phone_number: "917-801-6753", email: "gerry@yahoo.com", health_plan_id: 1, deductible: 950, out_of_pocket_max: 2200},
# 	{first_name: "Jacob", last_name: "Laporte", date_of_birth: "01/02/1976", age: 40, address: "111 Worth Street, New York, NY, 10013", phone_number: "917-216-2233", email: "jake@yahoo.com", health_plan_id: 2, deductible: 500, out_of_pocket_max: 3000},
# 	{first_name: "Dean", last_name: "Patros", date_of_birth: "06/24/1980", age: 36, address: "2357 Arthur Ave, Bronx, NY 10458", phone_number: "212-801-6753", email: "dean@yahoo.com", health_plan_id: 3, deductible: 50, out_of_pocket_max: 600},
# 	{first_name: "Sophie", last_name: "Johnson", date_of_birth: "11/02/1990", age: 26, address: "1421 3rd Ave, New York, NY 10028", phone_number: "212-566-2255", email: "sophie@yahoo.com", health_plan_id: 4, deductible: 1250, out_of_pocket_max: 3400},
# 	{first_name: "Sam", last_name: "Benedict", date_of_birth: "08/02/1996", age: 20, address: "91 E 7th St, New York, NY 10009", phone_number: "212-544-6753", email: "sam@yahoo.com", health_plan_id: 5, deductible: 1000, out_of_pocket_max: 3000}
# 	])

# Diagnosis.create([
# 	{ICD_code: "E11", diagnosis_name: "Diabetes mellitus II"},
# 	{ICD_code: "414.01", diagnosis_name: "Coronary artery disease"},
# 	{ICD_code: "401.1", diagnosis_name: "Benign essential hypertension"},
# 	{ICD_code: "034.0", diagnosis_name: "Hyperlipidemia"},
# 	{ICD_code: "346", diagnosis_name: "Migraine"},
# 	{ICD_code: "079.98", diagnosis_name: "Chlamydia"},
# 	{ICD_code: "461.9", diagnosis_name: "Acute sinusitis"},
# 	{ICD_code: "722.2", diagnosis_name: "Herniated disc"}
# 	])

# Medication.create([
# 	{RXCUI: "1171244", medication_name: "Glucophage"},
# 	{RXCUI: "343076", medication_name: "Insulin"},
# 	{RXCUI: "153165", medication_name: "Lipitor"},
# 	{RXCUI: "202554", medication_name: "Ecotrin"},
# 	{RXCUI: "196472", medication_name: "Zestril"},
# 	{RXCUI: "151392", medication_name: "Augmentin"},
# 	{RXCUI: "175184", medication_name: "Fioricet"},
# 	{RXCUI: "316326", medication_name: "Naproxen"},
# 	{RXCUI: "750149", medication_name: "Zithromax"},
# 	{RXCUI: "1163945", medication_name: "Gemfibrozil"},
# 	])

# HealthSystem.create([
# 	{name: "Columbia Presbyterian", address: "630 W 168th St, New York, NY 10032", er: true, urgent_care: false, pharmacy_clinic: false, walk_in_clinic: false, virtual_visit: true}, 
# 	{name: "NYU Medical Center", address: "550 1st Avenue, New York, NY 10016", er: true, urgent_care: true, pharmacy_clinic: false, walk_in_clinic: true, virtual_visit: false}, 
# 	{name: "Lennox Hill Med Ctr", address: "100 E 77th St, New York, NY 10075", er: true, urgent_care: true, pharmacy_clinic: true, walk_in_clinic: true, virtual_visit: false}, 
# 	{name: "Montefiore Med Ctr", address: "111 E 210th St, Bronx, NY 10467", er: true, urgent_care: false, pharmacy_clinic: false, walk_in_clinic: false, virtual_visit: true},
# 	{name: "Weill cornell downtown", address: "40 Worth St, NY, NY 10013", er: false, urgent_care: false, pharmacy_clinic: false, walk_in_clinic: true, virtual_visit: true },
# {name: "South Seaport NYU", address: "233 Broadway Suite 640, New York, NY 10279", er: false, urgent_care: true, pharmacy_clinic: false, walk_in_clinic: true, virtual_visit: true }
# 	])

# Provider.create([
# 	{name: "Michael Ford", address: "40 Worth street, NY, NY 10013", specialty: "11", phone: "212-341-7897", email: "michael@cornell.com", health_system_id: 5},
# 	{name: "Maria Tulpan", address: "40 Park Ave Suite 1, New York, NY 10016", specialty: "46", phone: "212-679-7363", email: "maria@maria.com", health_system_id: 2},
# 	{name: "Robert Segal", address: "211 E 51st St, New York, NY 10022", specialty: "06", phone: "212-906-7798", email: "robert@mc.com", health_system_id: 3},
# 	{name: "Sandeep Gulati", address: "4256 Bronx Blvd #5, Bronx, NY 10466", specialty: "13", phone: "718-515-4347", email: "sandeep@montefiore.org", health_system_id: 4},
# 	{name: "Jacob Cohen", address: "240 W 73rd St, New York, NY 10023", specialty: "14", phone: "212-362-4742", email: "jacob@columbia.com", health_system_id: 1}
# 	])


# UserDiagnosis.create([
# 	{user_id: 1, diagnosis_id: 8}, 
# 	{user_id: 2, diagnosis_id: 6}, 			
# 	{user_id: 3, diagnosis_id: 5},
# 	{user_id: 4, diagnosis_id: 2},
# 	{user_id: 4, diagnosis_id: 3},
# 	{user_id: 4, diagnosis_id: 4},
# 	{user_id: 5, diagnosis_id: 1},
# 	{user_id: 5, diagnosis_id: 4}
# 	])

# UserMedication.create([
# 	{user_id: 1, medication_id: 8},
# 	{user_id: 2, medication_id: 9},
# 	{user_id: 3, medication_id: 7},
# 	{user_id: 4, medication_id: 4},
# 	{user_id: 4, medication_id: 3},
# 	{user_id: 4, medication_id: 5},
# 	{user_id: 5, medication_id: 1},
# 	{user_id: 5, medication_id: 2},
# 	{user_id: 5, medication_id: 3}
# 	])

# UserHealthSystem.create([
# 	{user_id: 1, health_system_id: 1},
# 	{user_id: 2, health_system_id: 5},
# 	{user_id: 3, health_system_id: 4},
# 	{user_id: 4, health_system_id: 3},
# 	{user_id: 5, health_system_id: 2}
# 	])



# UserProvider.create([
# 	{user_id: 1, provider_id: 5}, 
# 	{user_id: 2, provider_id: 1},
# 	{user_id: 3, provider_id: 4},
# 	{user_id: 4, provider_id: 3},
# 	{user_id: 5, provider_id: 2},
# 	{user_id: 4, provider_id: 2},
# 	{user_id: 5, provider_id: 4}	
# 	])

# PlanProvider.create([
# 	{health_plan_id: 1, provider_id: 5},
# 	{health_plan_id: 2, provider_id: 1},
# 	{health_plan_id: 3, provider_id: 4},
# 	{health_plan_id: 4, provider_id: 3},
# 	{health_plan_id: 4, provider_id: 2},
# 	{health_plan_id: 5, provider_id: 2},
# 	{health_plan_id: 2, provider_id: 4}
# 	])

# Symptom.create([
# 	{name: "chest_pain"},
# 	{name: "shortness_of_breath"},
# 	{name: "headache"},
# 	{name: "burning_with_urination"},
# 	{name: "pain_with_walking"}
# 	])

# Duration.create([
# 	{length: 1},
# 	{length: 2},
# 	{length: 6},
# 	{length: 24}
# 	])

# Severity.create([
# 	{intensity: 1},
# 	{intensity: 2},
# 	{intensity: 3},
# 	{intensity: 4},
# 	{intensity: 5},
# 	{intensity: 6},
# 	{intensity: 7},
# 	{intensity: 8},
# 	{intensity: 9},
# 	{intensity: 10}
# 	])



