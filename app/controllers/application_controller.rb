class ApplicationController < ActionController::Base
	protect_from_forgery
	layout :set_layout
	before_filter :set_dynamic_pages

	def set_dynamic_pages
		@pages = Page.order("title ASC") unless ['sessions', 'main'].include?(controller_name)
	end

	def set_layout
		if ['sessions', 'main'].include?(controller_name)
			"admin"
		else
			"application"
		end
	end
end
