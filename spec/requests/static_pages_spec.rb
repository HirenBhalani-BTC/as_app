require 'spec_helper'

describe "StaticPages" do
  	let(:base_title) { "Ruby on Rails Tutorial Sample App" }
  	subject{page}
  	describe "Home page" do
  		 before {visit root_path}
		# it "should have the content 'Sample App'" do
		# 	# visit root_path
			
		# 	expect(page).to have_content('Sample App')
		# end
		it { should have_content('Sample App') }

		it "should have the title 'Home'" do
			
			expect(page).to have_title("#{base_title} | Home")
		end
		# it "should not have a custom page title" do
		# 	visit '/static_pages/home'
		# 	expect(page).not_to have_title('| Home')
		# end

		describe "for signed-in users" do
			let(:user) { FactoryGirl.create(:user)}
			before do
				FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
				FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
				sign_in user
				visit root_path
			end

			it "should render the user's feed" do
				user.feed.each do |item|
					expect(page).to have_selector("li##{item.id}",text: item.content)
				end
			end

			describe "follower/following counts" do
				let(:other_user) { FactoryGirl.create(:user)}
				before do
					other_user.follow!(user)
					visit root_path

					it { should have_link("0 following", href: following_user_path(user))}

					it { should have_link("1 following", href: followers_user_path(user))}
				end
			end
		end
	end

	describe "Help page" do
		it "should have the content 'Help'" do
			visit help_path
			expect(page).to have_content('Help')
		end
		it "should have the title 'Help'" do
			visit help_path
			expect(page).to have_title("Ruby on Rails Tutorial Sample App | Help")
		end
	end

	describe "About page" do
		it "should have the content 'About Us'" do
			visit about_path
			expect(page).to have_content('About Us')
		end
		it "should have the title 'About Us'" do
			 visit about_path
			# visit '/static_pages/about'
		expect(page).to have_title("Ruby on Rails Tutorial Sample App | About Us")
		end
	end
end
