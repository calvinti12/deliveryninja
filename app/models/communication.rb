class Communication
  def initialize(from,msg)
    @from = from
    @msg = msg
  end

  def check_user_message
    case @msg
    when /^referral/
      response = @from.consume_referral(/referral\s(.+)/.match(@msg)[1])
      p "I respond with #{response}" unless response.nil?
    when /^get referral$/
      response =  @from.request_referral
      p "I respond with #{response}" unless response.nil?
    else
      response = self.place_order
      p "I respond [to whom?] with #{response}" unless response.nil?
    end
  end

 

  def check_admin_message
    p @msg
    case @msg
    when /nuke all/
      response = @from.nuke_all
      p "I respond with #{response} about nuking"
    when /^get referral$/
      response = @from.request_referral
      p "referral? I'll respond with #{response}"
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
        "I am placing an order to #{User.find_admins.first.phone} with message ##{@from.id} #{@msg}"
      else
        "We're closed, check back later"
      end
    else
      # Don't send any response, this user isn't admitted
    end
  end

end
