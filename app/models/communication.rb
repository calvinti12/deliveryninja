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
          send_sms(@from,"You are now admitted")
        else
          send_sms(@from,"You still need more referrals")
        end
      else #referral used? something else?
        p "Could not use referral"  # don't message submitter
      end
    when /^get referral$/
      if @from.admitted?
        referral = @from.request_referral
        if referral
          send_sms(@from,"Share this code #{referral.code}")
        else
          send_sms(@from,"Too many referrals created recently, take a break!")
        end
      end
    else
      if @from.admitted?
        response = self.place_order
        send_sms(response[0],response[1])
      end
    end
  end

  def send_sms(to,body)
    @client.messages.create(
      from: @twilio_number,
      to: to.phone,
      body: body
    )
  end


  def check_admin_message
    p @msg
    case @msg
    when /nuke all/
      response = @from.nuke_all
      p "I respond with #{response} about nuking"
    when /^get referral$/
      referral = @from.request_referral
      send_sms(@from,"Share this code #{referral.code}")
    when /^REPLY #\d+/
      message = /^REPLY #(\d+)\s(.+)/.match(@msg)
      send_sms(User.find(message[1]).phone,message[2])
    when /close/
      @from.change_available(false)
      send_sms(@from.phone,"You are no longer available")
    when /open/
      @from.change_available(true)
      send_sms(@from.phone,"You have turned off availability")
    else
      p "I don't know what you want me to do."
    end
  end

  def place_order
    # choose a random admin for this
    offset = rand(User.admins.available.count)
    chosen_admin = User.admins.available.offset(offset).first
    msg = ""
    unless chosen_admin.nil?
      msg = "##{@from.id} #{@msg}"
    else
      msg = "We're closed, check back later"
    end
    [chosen_admin,msg]
  end

end
