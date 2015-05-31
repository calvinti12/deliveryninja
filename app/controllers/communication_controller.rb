class CommunicationController < ApplicationController
  def receive(phone = "333",message= "hello world")
    communication = Communication.new(phone,message)
    user = User.find_or_create_by(:phone => phone)
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
