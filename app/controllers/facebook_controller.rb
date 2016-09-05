class FacebookController < ApplicationController
  before_action :authenticate_user!
  def login
      @current = User.find_by(id: session[:email])
      @user =  User.all
  end
end
