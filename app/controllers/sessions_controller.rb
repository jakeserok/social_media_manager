class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Logged in successfully'
    else
      flash[:alert] = 'Invalid Credentials'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged Out'
  end

  def omniauth
    Rails.logger.info auth

    User.from_omniauth(request.env['omniauth.auth'])

    user = User.find_by(email: auth.info.email)

    if user.provider == 'google_oauth2'
      session[:user_id] = user.id
      flash[:notice] = "Successfully logged in."
      redirect_to root_path
    else
      flash[:alert] = "Sign in unsuccessful."
      redirect_to root_path
    end

    # if user.valid?
    #   session[:user_id] = user.id
    #   flash[:message] = "Successfully logged in."
    #   redirect_to root_path
    # else
    #   # flash[:message] = user.errors.full_message.join(', ')
    #   redirect_to root_path
    # end
  end

  private
  
  def auth
    request.env['omniauth.auth']
  end

end
