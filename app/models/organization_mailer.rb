class OrganizationMailer < MailForm::Base
  attribute :currently_registered_email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :nickname,  :captcha  => true
  attribute :org_name
  attribute :NOTICE

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  

    def headers
    {
      :subject => "Gelfand Center Sign Up notice",
      :to => "#{currently_registered_email}",
      :from => %("Gelfand" <gelfand@gelfand.com>)
    }

    end 


end