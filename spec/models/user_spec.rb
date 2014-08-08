require 'spec_helper'

describe User do
  before {@user=User.new(name:"Example user",email:"user@example.com",password:"foobar",password_confirmation:"foobar")}
  
  subject {@user}

  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token)}

  it { should respond_to(:authenticate)}
  it{ should respond_to(:admin)}

<<<<<<< HEAD
  it{ should respond_to(:microposts)}
  it{ should respond_to(:feed)}

  it { should be_valid }
  it { should_not be_admin}
=======
  it { should respond_to(:microposts)}

  it { should be_valid }
  it { should_not be_admin}



>>>>>>> user-microposts
  
  describe "with admin attribute set to 'true'" do 
    before do
      @user.save!
      @user.toggle!(:admin)
    end
    it { should be_admin }
  end

  describe "When name is not present" do
  	before {@user.name=""}
  	it{should_not be_valid }
  end

  describe "When email is not present" do
  	before {@user.email=""}
  	it{should_not be_valid}
  end

  describe "When name is too long" do
  	before {@user.name="a"*51}
  	it{should_not be_valid}
  end

  describe "whene email formate is invalid" do
  	it "should be invalid" do
  		add=%w[user@foo,com user_At_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
  		add.each do |invalid_add|
  			@user.email=invalid_add
  			expect(@user).not_to be_valid
  		end
  	end
  end

  describe "when email formate is valid" do
  	it "should be valid" do
  		add=%w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
  		add.each do |valid_add|
  			@user.email=valid_add
  			expect(@user).to be_valid
  		end
  	end
  end

  describe "when email address is already taken" do
  	before do
  		user_with_same_email=@user.dup
  		user_with_same_email.email=@user.email.upcase
  		user_with_same_email.save 
  	end
  	it{should_not be_valid}
  end

  describe "when password is not present" do
  	before do
  		@user=User.new(name:"Example User",email:"user@example.com",password:"",password_confirmation:"")
  	end
  	it {should_not be_valid}
  end

  describe "when password doesn't match confirmation" do
  	before {@user.password_confirmation="mismatch"}
  	it {should_not be_valid}
  end



  describe "with a password that's too short" do
  	before {@user.password=@user.password_confirmation="a"*5}
  	it{should be_invalid}
  end

  describe "return value of uthenticate methode" do
  	before {@user.save}
  	let(:found_user){User.find_by(email: @user.email)}

  	describe "with valid password" do
  		it {should eq found_user.authenticate(@user.password)}
  	end

  	describe "with invalid password" do
  		let (:user_for_invalid_password) { found_user.authenticate("invalid")}

  		it { should_not eq user_for_invalid_password}
  		specify { expect(user_for_invalid_password).to be_false}
  	end
  end

  describe "remember_token" do
  	before {@user.save}
  	its(:remember_token){ should_not be_blank}
  end

<<<<<<< HEAD


  describe "micropost associations" do
    before { @user.save}
    let!(:older_micropost) do
        FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
=======
  describe "mocropost associations" do
    before { @user.save}
    let!(:order_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user :@user,created_at: 1.hour.ago)
>>>>>>> user-microposts
    end

    it "should have the right microposts in the right order" do
      expect(@user.microposts.to_a).to eq [newer_micropost,older_micropost]
    end
<<<<<<< HEAD

    it "should destroy associated microposts" do
      microposts=@user.microposts.to_a
      @user.destroy
      expect(microposts).not_to be_empty
      microposts.each do |mcr|
        expect(Micropost.where(id: mcr.id)).to be_empty
      end
    end

    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
      end

      its(:feed) { should include(newer_micropost)}
      its(:feed) { should include(older_micropost)}
      its(:feed) { should_not include(unfollowed_post)}
    end
=======
>>>>>>> user-microposts
  end
end
