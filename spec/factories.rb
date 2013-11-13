# More info:
# https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md

OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
  provider: 'twitter',
  uid: '12345',
  info: { name: 'John Doe', image: '' },
  credentials: { token: "abc_def", secret: "123_456" }
})

OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
  provider: 'google_oauth2',
  uid: '12345',
  info: { email: 'john.doe@example.com', name: 'John Doe', image: '' },
  credentials: { token: "abc_def", secret: "123_456" }
})

OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
  provider: 'facebook',
  uid: '12345',
  info: { email: 'john.doe@example.com', name: 'John Doe', image: '' },
  credentials: { token: "abc_def", secret: "123_456" }
})

FactoryGirl.define do
  factory :user do
    email     "john.doe@example.com"
    name      "John Doe"
    password  "password"

    factory :user_with_authentication do
      ignore do
        provider "twitter"
      end
      after(:create) do |user, evaluator|
        FactoryGirl.create(:authentication, user: user, provider: evaluator.provider)
      end
    end
  end

  factory :authentication do
    provider "provider"
    uid "12345"
    user
  end

end
