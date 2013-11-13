require 'spec_helper'

feature 'Visitor signs in' do

  scenario 'with Google' do
    create_user 'john.doe@example.com', 'password', 'John Smith'
    sign_in_with_provider 'Google'

    user_should_be_signed_in_as 'John Smith'
  end

  scenario 'with Twitter' do
    create_user_with_provider 'john.doe@twitter.com', 'twitter'
    sign_in_with_provider 'Twitter'

    user_should_be_signed_in
  end

  scenario 'with Facebook after a Google signin' do
    create_user_with_provider 'john.doe@example.com', 'google_oauth2', 'John Smith'
    sign_in_with_provider 'Facebook'

    user_should_be_signed_in_as 'John Smith'
  end
end
