class SearchController < ApplicationController
	before_filter :require_login
	
	def search
		@searched = false
		@results = []
		@response = nil

		if !params[:q].blank?
			@response = github_client.repos search_options
			items = @response.body.items
			
			# Pagination
			@results = WillPaginate::Collection.create(current_page, items.count, @response.total_count) do |pager|
			   pager.replace(items)
			end

			@searched = true
		end
	end

	private
		def github_client
			Github::Client::Search.new do |config|
				config.oauth_token = current_user.oauth_token
				config.auto_pagination = true
				config.per_page = 30
			end
		end

		def search_options
			options_hash = {}
			options_hash[:q] = params[:q]
			options_hash[:page] = current_page
			if !params[:s].blank? && [:stars].include?(params[:s].downcase.to_sym)
				options_hash[:sort] = params[:s]
				options_hash[:order] = params[:o] if !params[:o].blank? && [:desc, :asc].include?(params[:o].downcase.to_sym)
			end
			if !params[:l].blank? && ![:any].include?(params[:l].downcase.to_sym)
				options_hash[:q] = options_hash[:q]+"+language:"+params[:l]
			end
			options_hash
		end

		def current_page
			params[:page].blank? ? 1 : params[:page]
		end

end
