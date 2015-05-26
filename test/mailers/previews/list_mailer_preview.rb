# Preview all emails at http://localhost:3000/rails/mailers/list_mailer
class ListMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/list_mailer/send
  def send
    ListMailer.send
  end

end
