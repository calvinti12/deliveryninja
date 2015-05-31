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
    return "user already admitted" if self.admitted?
    referral = Referral.where(:code => code).last
    return "referral already taken" unless referral.consumed_by.nil?
    referral.consumed_by = "#{self.phone}"
    referral.save
    self.check_admission
  end

  def check_admission
    current_referrals = Referral.where(:consumed_by => self.phone).count 
    p current_referrals
    p "hello worldddddddd"
    if current_referrals >= REQUIRED_REFERRALS
      self.admitted = true
      self.save
    else
      self.admitted = false
      self.save
    end
  end

end
