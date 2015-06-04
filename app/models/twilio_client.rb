class TwilioClient
  include Singleton

  def send_sms(to_number,message)
    client.account.messages.create(
      from: ENV['TWILIO_NUMBER'],
      to: to_number,
      body: message)
  end

  private

  def client
      @client ||= Twilio::REST::Client.new
  end
end
