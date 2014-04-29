class HomeController < ApplicationController
    def index
        render 'home/index', :layout => "application2"
    end
end