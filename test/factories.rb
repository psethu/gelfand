FactoryGirl.define do
	factory :individual do
		f_name "John"
		l_name "Doe"
		dob Date.today - 3.years
		role 0
		active true
	end
end