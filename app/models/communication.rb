class Communication
  def initialize(from,msg)
    @from = from
    @msg = msg
  end

  def check_user_message
    case @msg
    when /^referral/
      @from.consume_referral(/referral\s(.+)/.match(@msg)[1])
    when /^get referral$/
      @from.request_referral
    else
      self.place_order
    end
  end

 

  def check_admin_message
    p @msg
    case @msg
    when /nuke all/
      p "nuke all the things"
    when /^get referral$/
      @from.request_referral
    when /^REPLY #\d+/
      message = /^REPLY #(\d+)\s(.+)/.match(@msg)
      p "admin replying to #{User.find(message[1]).phone} with message #{message[2]}"
    when /close/
      p "admin closes store"
    when /open/
      p "admin opens store"
    else
      p "I don't know what you want me to do."
    end
  end

  def place_order
    store_open = true #placeholder
    if @from.admitted?
      if store_open
        p "I am placing an order to #{User.find_admins.first.phone} with message ##{@from.id} #{@msg}"
      else
        p "We're closed, check back later"
      end
    else
      # Don't send any response, this user isn't admitted
    end
  end

end
