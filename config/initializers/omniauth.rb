Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"],  {
    prompt: 'select_account',
    image_aspect_ratio: 'square',
    image_size: 200,
    scope: 'userinfo.profile,userinfo.email',
    provider_ignores_state: true
  }
end
OmniAuth.config.full_host = Rails.env.production? ? 'https://domain.com' : 'http://localhost:3000'
