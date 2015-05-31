class Communication
  def initialize(from_user,msg)
    @from = from
    @msg = msg
  end

  def check_user_message
    case @msg
    when /^referral/
      @from.consume_referral(/referral\s(.+)/.match(@msg))
    when /^get referral$/
      @from.request_referral
    else
      p "I am placing an order"
    end
  end



  def check_admin_message
    case @msg
    when /nuke all/
      p "nuke all the things"
    when /^get referral$/
      @from.request_referral
    when /^\REPLY #\d+/
      p "admin replying to someone"
    when /close/
      p "admin closes store"
    when /open/
      p "admin opens store"
    else
      p "I don't know what to do"
    end
  end

end
