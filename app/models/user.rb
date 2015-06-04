class User < ActiveRecord::Base
  include User::Settings
  has_many :referrals
  has_many :consumed_referrals, foreign_key: "consumer_id", class_name: "Referral"

  scope :admins, -> { where(admin: true) }
  scope :available, -> { where(available: true)}

  def request_referral
    if referrals_available
      referrals.create
    else
      nil
    end
  end

  def referrals_available
    return true if self.admin?
    return false unless self.admitted?
    referrals.where("created_at >= ?", Time.zone.now.beginning_of_day - REFERRAL_PERIOD).count < MAX_REFERRALS
  end

  def admitted?
    return true if self.admin?
    consumed_referrals.count >= REQUIRED_REFERRALS || consumed_referrals.where(:user_id => User.admins).count > 0
  end

  def change_available(value)
    self.available = value
    self.save
  end
end
