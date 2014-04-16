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
end