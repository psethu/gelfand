class OrganizationMailer < MailForm::Base
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :nickname,  :captcha  => true
  attribute :org_name
  attribute :message

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  

    def headers
    {
      :subject => "Gelfand Center Sign Up notice",
      :to => "#{email}",
      :from => %("Gelfand" <gelfand@gelfand.com>)
    }

    end 


end