class Communication
  def initialize(from,msg)
    @from = from
    @msg = msg
  end

  def check_user_message
    case @msg
    when /^referral/
      code = /referral\s(.+)/.match(@msg)[1]
      r = Referral.find_by_code(code)
      if r.nil?
        p "not a referral code" # don't message submitter
        return nil 
      end
      if r.consume!(@from)
        if @from.admitted?
          p "You are admitted"
        else
          p "You need more referrals"
        end
      else
        p "Could not use referral"  # don't message submitter
      end
    when /^get referral$/
      request_referral
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
      request_referral
    when /^REPLY #\d+/
      message = /^REPLY #(\d+)\s(.+)/.match(@msg)
      p "admin replying to #{User.find(message[1]).phone} with message #{message[2]}"
    when /close/
      @from.change_available(false)
      p "admin closes store"
    when /open/
      @from.change_available(true)
      p "admin opens store"
    else
      p "I don't know what you want me to do."
    end
  end

  def request_referral
    r = @from.request_referral
    if r
      p "Referral created #{r.code}"
    else
      p "Could not create referral"
    end
  end

  def place_order
    # choose a random admin for this
    offset = rand(User.admins.available.count)
    chosen_admin = User.admins.available.offset(offset).first
    if @from.admitted?
      unless chosen_admin.nil?
        p "I am placing an order to #{User.admins.first.phone} with message ##{@from.id} #{@msg}"
      else
        "We're closed, check back later"
      end
    else
      # Don't send any response, this user isn't admitted
    end
  end

end
