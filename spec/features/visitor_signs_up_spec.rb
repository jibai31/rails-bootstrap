require 'spec_helper'

feature 'Visitor signs up' do
  scenario 'with valid email and password' do
    sign_up_with 'valid@example.com', 'password'

    user_should_be_signed_in
  end

  scenario 'with invalid email' do
    sign_up_with 'invalid_email', 'password'

    user_should_be_signed_out
  end

  scenario 'with blank password' do
    sign_up_with 'valid@example.com', ''

    user_should_be_signed_out
  end 

  scenario 'with Google' do
    sign_in_with_provider "Google"

    user_should_be_signed_in
  end

  scenario 'with Twitter' do
    sign_in_with_provider "Twitter"
    fill_in "Email", with: "john.doe@twitter.com"
    click_button 'Sign up'

    user_should_be_signed_in
  end
end
