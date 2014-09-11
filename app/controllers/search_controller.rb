class SearchController < ApplicationController
	before_filter :require_login
	
	def search
		@searched = false
		@results = []
		@response = nil

		unless params[:q].blank?
			@response = github_client.repos search_options
			@results = @response.body.items
			# @languages = @results.map{|r| r.language}
			@searched = true
		end
	end

	private
		def github_client
			Github::Client::Search.new do |config|
				config.oauth_token = current_user.oauth_token
				config.auto_pagination = true
			end
		end

		def search_options
			options_hash = {}
			options_hash[:q] = params[:q]
			if !params[:s].blank? && [:stars].include?(params[:s].downcase.to_sym)
				options_hash[:sort] = params[:s]
				options_hash[:order] = params[:o] if !params[:o].blank? && [:desc, :asc].include?(params[:o].downcase.to_sym)
			end
			if !params[:l].blank? && ![:any].include?(params[:l].downcase.to_sym)
				options_hash[:q] = options_hash[:q]+"+language:"+params[:l]
			end
			options_hash
		end

end
