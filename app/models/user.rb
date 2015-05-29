class User < ActiveRecord::Base
  has_many Referral
end
