class SearchController < ApplicationController
	def result
		req = Amazon::Ecs.item_search(params[:search],
			{:response_group => 'ItemAttributes,Accessories,AlternateVersions,BrowseNodes,EditorialReview,OfferFull,OfferSummary,Reviews,Images,Offers,SalesRank', :sort => 'salesrank', itempage: params[:page]}
			)
		@results = req.items
		# @keyword = CGI::escape(params[:q])

  #   @results = if @keyword
  #     tag = Tag.find_or_create_by_name(params[:q])
  #     Tag.fetch_amazon_data(tag) if tag.products.blank?
  #     tag.products.page(params[:page])
  #   else
  #     []
  #   end

	end

	def product_category
		req = Amazon::Ecs.item_search(nil, {
			:search_index => "Books", 
			:power => "binding:Hardcover or Paperback",
			:response_group => 'ItemAttributes,Accessories,AlternateVersions,BrowseNodes,EditorialReview,OfferFull,OfferSummary,Reviews,Images,Offers,SalesRank', :sort => 'salesrank', itempage: params[:page]
			})
		@results = req.items

		render template: 'search/result'
	end
end

