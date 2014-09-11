class SearchController < ApplicationController

	def search
		@searched = false
		@results = []

		search_term = params[:q]
		order = params[:o]
		sort_by = params[:s]
		language = params[:l]

		unless search_term.blank?
			@searched = true
			@results = []
		end
	end

end
