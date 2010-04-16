class UsersController < ApplicationController
  before_filter :check_event

  def index
    @users = @event.users
  end

  def subscribe
    @user = User.new(:event => @event)
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'Sua inscrição foi recebida. Muito Obrigado!'
      redirect_to users_path(params[:slug])
    else
      render :action => "new"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to(@user)
    else
      render :action => "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to(users_url)
  end

  private
    def check_event
      @event = Event.find_by_slug(params[:slug])
    end
end
