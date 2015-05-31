class Communication
  def initialize(from,msg)
    @from = from
    @msg = msg
  end

  def check_user_message
    case @msg
    when /^referral/
      p "I am entering a referral"
    when /^get referral$/
      p "I want a referral"
    else
      p "I am placing an order"
    end
  end

  def check_admin_message
    case @msg
    when /nuke all/
      p "nuke all the things"
    when /^get referral$/
      p "admin wants a referral"
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
