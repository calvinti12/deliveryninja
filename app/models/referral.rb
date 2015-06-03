class Referral < ActiveRecord::Base
  belongs_to :user
  belongs_to :consumer, class_name: "User"

  before_validation(on: :create) do
    self.code = (0...8).map { (65 + rand(26)).chr }.join
  end

  def consume!(new_consumer)
    return false if consumer || new_consumer.admitted?
    self.consumer = new_consumer
    save
  end
end
