class ListMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.list_mailer.send.subject
  #
  def send(list, sender_email, to_email, message)
    @list = list
	@message = message
    mail to: to_email, from: sender_email, subject: "You've been sent a new List"
  end
end
