FactoryGirl.define do
	factory :user do
		sequence(:name) { |n| "Persona #{n}" }
		sequence(:email) { |n| "persona#{n}@ejemplo.com" }
		password "12345678"
		password_confirmation "12345678"

		factory :admin do
			admin true
		end
	end

	factory :micropost do
		content "Lorem ipsum"
		user
	end
end