class SearchController < ApplicationController
	def result
		req = Amazon::Ecs.item_search(params[:search],
			{:response_group => 'ItemAttributes,Accessories,AlternateVersions,BrowseNodes,EditorialReview,OfferFull,OfferSummary,Reviews,Images,Offers,SalesRank', :sort => 'salesrank', itempage: params[:page]}
			)
		@results = req.items

	end

	def product_category
		req = Amazon::Ecs.item_search(nil, {
			:search_index => "Books", 
			:power => "binding:Hardcover or Paperback",
			:response_group => 'ItemAttributes,Accessories,AlternateVersions,BrowseNodes,EditorialReview,OfferFull,OfferSummary,Reviews,Images,Offers,SalesRank', :sort => 'salesrank', itempage: params[:page]
			})
		@results = req.items

		render template: 'result'
	end
end

