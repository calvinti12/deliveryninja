class CommunicationController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def receive()
    phone = params[:phone]
    message = params[:msg]
    user = User.find_or_create_by(:phone => phone)
    communication = Communication.new(user,message)
    if user.admin?
      communication.check_admin_message 
    else
      communication.check_user_message
    end
    #determine if msg relates to referrals 
    #determine if user is admitted already
    #determine if store is open 
    render :nothing => true
  end

end
