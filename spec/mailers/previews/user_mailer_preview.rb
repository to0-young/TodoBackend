# Preview all emails at http://localhost:3000/rails/mailers/user
class UserMailerPreview < ActionMailer::Preview
  def recover_email
    UserMailer.with(user: User.first).recover_email
  end
end
