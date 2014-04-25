FactoryGirl.define do
	factory :individual do
		f_name "John"
		l_name "Doe"
		role 0
		active true
	end

	factory :organization do
		name "Fringe"
		description "A student organization primarily focused on buggy."
		department "Student Activities"
		active true
		is_partner false
	end

	factory :bg_check do
		status 0
		date_requested 10.days.ago
	end

	factory :program do
		name "CMU School of Music"
		description "Assisting with the School of Music's Elementary School Program"
		start_date 10.days.from_now
		end_date 2.months.from_now
		cmu_facilities "Margaret Morrison Hall"
		num_minors 21
		num_adults_supervising 13
	end

	factory :user do
		email "default@yahoo.com"
		password "password1"
		password_confirmation "password1"
	end
end