OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
	# provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
	provider :github, "7ce2c9d36b3d0dbcffa0", "ca6fd9cd56d012a481db74f1a1c090ba163c7aeb", scope: "repo"
end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}