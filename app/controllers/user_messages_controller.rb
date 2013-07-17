class UserMessagesController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def create
    user = UserMessage.new(params[:user_message])
    if user.save
      render js: "$('#u337-4.clearfix.grpelem p').html('comment successfully posted');$('#u337-4.clearfix.grpelem p').css('color', 'green')"
    else
      render js: "$('#u337-4.clearfix.grpelem p').html('failed to post a comment');"
    end
  end
end
