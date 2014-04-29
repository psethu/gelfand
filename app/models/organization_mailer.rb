class OrganizationMailer < MailForm::Base
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :nickname,  :captcha  => true
  attribute :org_name

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  

    def headers
    {
      :subject => "You have been temporarily given a Membership to \"#{org_name}\". To officially be in the system, sign up at: http://gelfand-gelfand.rhcloud.com/users/sign_up",
      :to => "#{email}",
      :from => %("Gelfand" <gelfand@gelfand.com>)
    }

    end 


end