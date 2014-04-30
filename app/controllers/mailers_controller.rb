class MailersController < ApplicationController
  def new
    @mailer = Mailer.new
  end

  def create
    @mailer = Mailer.new(mailer_params)
    @mailer.request = request

    if @mailer.deliver
      flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
    def mailer_params
      params.require(:mailer).permit(:name, :email, :message, :nickname) 
    end
end
