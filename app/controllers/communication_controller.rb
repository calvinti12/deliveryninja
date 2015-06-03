class CommunicationController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def receive()
    phone = params[:phone]
    message = params[:msg]
    # make the first user an admin
    if User.admins.count == 0
      user = User.find_or_create_by(:phone => phone, :admin => true)
    else
      user = User.find_or_create_by(:phone => phone)
    end
    communication = Communication.new(user,message)
    if user.admin?
      communication.check_admin_message 
    else
      communication.check_user_message
    end
    #render :nothing => true
    render :text => "ok"
  end

end
