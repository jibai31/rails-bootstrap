RailsBootstrap::Application.routes.draw do
  devise_for :users,
    controllers: {
      registrations: "registrations",
      omniauth_callbacks: "authentications"
    }
  root 'static_pages#home'
end
