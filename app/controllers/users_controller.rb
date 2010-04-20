class UsersController < ApplicationController
  before_filter :check_event
  layout "application"

  def index
    if params['recents']
      @users = User.all(:conditions => "id > #{params['recents']} and event_id = #{@event.id}", :order => 'id DESC')
      @page = 1
    else
      @page = params.fetch(:page, 1).to_i
      @users = @event.users.paginate(:page => @page, :per_page => 10, :order => 'id DESC')
    end
    respond_to do |format|
      format.html
      format.js { render(:content_type => :js, :text => {:users => @users, :next_page => User.count}.to_json) }
    end
  end

  def subscribe
    @user = User.new(:event => @event)
    @twitters = User.twitters(@event) || []
  end

  def create
    @user = User.new(params[:user])
    @twitters = User.twitters(@event) || []
    unless params[:user][:twitter].blank?
      twitter = Twitter.user(params[:user][:twitter].gsub(/http:\/\/(.*)\/(.*)/, "\\2"))
      @user.twitter_profile = twitter.screen_name
      @user.twitter_name = twitter.name
      @user.twitter_image = twitter.profile_image_url
      @user.twitter_url = twitter.url
      @user.twitter_description = twitter.description
      @user.twitter_location = twitter.location
      @user.twitter_friends = twitter.friends_count
      @user.twitter_followers = twitter.followers_count
      @user.twitter_statuses_count = twitter.statuses_count
      @user.twitter_since = twitter.created_at
    end
    if @user.save
      flash[:notice] = 'Sua inscrição foi recebida. Muito Obrigado!'
      redirect_to users_path
    else
      render :action => "subscribe"
    end
  end

  # def update
  #   @user = User.find(params[:id])
  #   if @user.update_attributes(params[:user])
  #     flash[:notice] = 'User was successfully updated.'
  #     redirect_to(@user)
  #   else
  #     render :action => "edit"
  #   end
  # end
  # 
  # def destroy
  #   @user = User.find(params[:id])
  #   @user.destroy
  #   redirect_to(users_url)
  # end

  private
    def check_event
      @event = Event.find(1)
    end
end
