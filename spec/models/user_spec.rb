require 'spec_helper'

describe User do

	before do
		@user = User.new(name: "Persona", email: "ejemplo@ejemplo.com", password: "12345678", 
		password_confirmation: "12345678" )
	end

	subject { @user }

	it { should respond_to(:name)}
	it { should respond_to(:email)}
	it { should respond_to(:fici_name)}
	it { should respond_to(:password)}
	it { should respond_to(:password_confirmation)}
	it { should respond_to(:microposts)}

	describe "when name is not present" do
	  	before {@user.name = ''}
	  	it {should_not be_valid}
	end

	describe "when email is not present" do
	  	before {@user.email = ''}
	  	it {should_not be_valid}
	end

	describe "when name is too long" do
		before { @user.name = "a" * 51 }
		it { should_not be_valid }
	end


	describe "micropost associations" do
		
		before { @user.save }

		let!(:older_micropost) do
			FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
		end

		let!(:newer_micropost) do
			FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
		end

		it "should have the right microposts in the right order" do
			@user.microposts.should == [newer_micropost, older_micropost]
		end

		it "should destroy associated microposts" do
			microposts = @user.microposts
			@user.destroy
			microposts.each do |micropost|
				Micropost.find_by_id(micropost.id).should_be_nil
			end
		end
	end

end

