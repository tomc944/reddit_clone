class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username],params[:user][:password])

    if @user.nil?
      render :new
    else
      login!(@user)
      #redirect_to page
    end
  end

  def destroy
    logout!
    redirect_to new_sessions_url
  end

end
