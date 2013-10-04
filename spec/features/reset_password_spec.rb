require 'spec_helper'

describe "Reset Password" do

  it "resets my password" do
    User.destroy_all
    signup("jim@jimvanfleet.com")
    logout
    click_link "Sign In"
    click_link "Forgot your password?"
    within("#new_user") do
      fill_in "Email", :with => "jim@jimvanfleet.com"
      click_button "Send me reset password instructions"
    end

    open_email("jim@jimvanfleet.com")
    current_email.click_link "Change my password"
    within("#new_user") do
      fill_in "user_password", :with => "87654321"
      fill_in "user_password_confirmation", :with => "87654321"
      click_button "Change my password"
    end
    click_link "Sign Out"
    click_link "Sign In"
    within("#new_user") do
        fill_in "Email", :with => "jim@jimvanfleet.com"
        fill_in "Password", :with => "87654321"
        click_button "Sign in"
      end
    expect(page).to have_content("success")
  end
end

#empty database
#sign up
#log out
#go to sign in
#click forgot pw page
#enter email into...
#click submit
#open Email
#click link in Email
#enter a new password
#sign out
#sign in with new password