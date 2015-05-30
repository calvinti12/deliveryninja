class User < ActiveRecord::Base
  include User::Settings
  has_many :referrals

  def request_referral
    #if user can give referrals
    #if user has not sent out too many referrals
    referral = Referral.create!(
      :code => "#{(0...8).map { (65 + rand(26)).chr }.join}",
      :created_by => self.phone
    )
    referral.code
  end

  def consume_referral(code)
    referral = Referral.where(:code => code).last
    return false unless referral.consumed_by.nil?
    referral.consumed_by = "#{self.phone}"
    referral.save
  end

  def admitted?
    if self.referrals_received.nil?
      false
    else
      self.referrals_received >= REQUIRED_REFERRALS 
    end
  end
  
end
