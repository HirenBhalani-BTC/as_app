require 'spec_helper'

describe "StaticPages" do
  	let(:base_title) { "Ruby on Rails Tutorial Sample App" }
  	subject{page}
  	describe "Home page" do
  		 before {visit '/static_pages/home'}
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
	end

	describe "Help page" do
		it "should have the content 'Help'" do
			visit '/static_pages/help'
			expect(page).to have_content('Help')
		end
		it "should have the title 'Help'" do
			visit '/static_pages/help'
			expect(page).to have_title("Ruby on Rails Tutorial Sample App | Help")
		end
	end

	describe "About page" do
		it "should have the content 'About Us'" do
			visit '/static_pages/about'
			expect(page).to have_content('About Us')
		end
		it "should have the title 'About Us'" do
			# visit about_path
			visit '/static_pages/about'
		expect(page).to have_title("Ruby on Rails Tutorial Sample App | About Us")
		end
	end
end
