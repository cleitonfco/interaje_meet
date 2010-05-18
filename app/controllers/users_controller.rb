class UsersController < ApplicationController
  before_filter :check_event
  before_filter :check_twitters, :only => [:subscribe, :create]
  layout "application"

  def index
    if params['recents']
      @users = User.recents(@event.id, params['recents'])
      @page = Subscription.by_event(@event.id).count - 1
    else
      @page = params.fetch(:page, 1).to_i
      @subscriptions = Subscription.by_event(@event.id).paginate(:page => @page, :per_page => 10)
    end
    respond_to do |format|
      format.html
      format.js { render(:content_type => :js, :text => {:users => @users, :next_page => @page + 1}.to_json) }
    end
  end

  def subscribe
    @user = User.new
  end
  
  def subscribe_event
    @user = User.by_token(params[:user].to_i, params[:token])
    if @user
      @user.events << @event
      @user.save
      flash[:notice] = "Sua inscrição para o evento: #{@event.name} foi confirmada. Muito Obrigado!"
      redirect_to users_path
    else
      flash[:notice] = "Não foi possível concluir a confirmação. Usuário não encontrado!"
      redirect_to users_path
    end
     
  end

  def create
    @user = User.new(params[:user])
    @user.events << @event
    unless params[:user][:twitter].blank?
      twitter = Twitter.user(params[:user][:twitter].gsub(/https?:\/\/(.*)\/(.*)/, "\\2"))
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
      if RAILS_ENV == 'production'
        unless @user.twitter_profile.blank?
          begin
            config = YAML::load(ERB.new(IO.read(RAILS_ROOT + "/config/database.yml")).result)["twitter"]
            httpauth = Twitter::HTTPAuth.new(config['user'], config['password'])
            client = Twitter::Base.new(httpauth)
            client.update("@#{@user.twitter_profile} Obrigado por se inscrever no #interaje. Esperamos você dia 18/05 no auditório da FIEPI 8º andar, a partir de 18h30")
          rescue Exception => e
            puts e.to_s
          end
        end
      end
      redirect_to users_path
    else
      render :action => "subscribe"
    end
  end

  private
    def check_event
      @event = Event.find(2)
    end

    def check_twitters
      @twitters = @event.users.twitters || []
    end
end
