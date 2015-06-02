class User < ActiveRecord::Base
  include User::Settings
  has_many :referrals

  def request_referral
    if referrals_available
      referral = Referral.create!(
        :code => "#{(0...8).map { (65 + rand(26)).chr }.join}",
        :created_by => self.phone
      )
      referral.code
    else
      "too many referrals have been sent recently"
    end
  end

  def referrals_available
    return true if self.admin?
    return false unless self.admitted?
    if Referrals.where(:created_by => self.phone).where("created_at >=?", Time.zone.now.beginning_of_day-REFERRAL_PERIOD).count >= MAX_REFERRALS
      false
    end
    
  end

  def consume_referral(code)
    return "user already admitted" if self.admitted?
    referral = Referral.where(:code => code).first
    return "referral already taken" unless referral.consumed_by.nil?
    referral.consumed_by = "#{self.phone}"
    referral.save
    self.check_admission
  end

  def check_admission
    return true if self.admitted?
    current_referrals = Referral.where(:consumed_by => self.phone).count 
    if current_referrals >= REQUIRED_REFERRALS
      self.admitted = true
      self.save
      #TODO
      return "MESSAGE USER YAY YOU ARE ADMITTED"
    elsif current_referrals > 0
      return "You still need #{ REQUIRED_REFERRALS - current_referrals} to enter"
    end
  end

  def self.find_admins
    self.where(:admin => true)
  end

end
