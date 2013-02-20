
class UsersController < ApplicationController

  # caches_page :resume
  # cache_sweeper :user_sweeper

  layout 'resume'
  
  def gallery
    @gallery = Gallery.where( :galleryname => params[:galleryname] ).first
    authorize! :show, @gallery

    @user = @gallery.user
    @title = "Gallery #{@gallery.name} of #{@user.username}"
  end

  def show
    if Rails.env.production? && 'piousbox.com' != @domain
      authorize! :not_found, User.new
      redirect_to "http://piousbox.com#{request.path}"

    elsif Rails.env.development? && 'pi.local' != @domain
      authorize! :not_found, User.new
      redirect_to "http://pi.local:3010#{request.path}"

    else
      @user = User.where( :username => params[:username] ).first
      authorize! :show, @user
      if @user.blank?
        render :not_found
      else

        @profile = UserProfile.where( :user => @user, :lang => @locale ).first
        @title = "resume #{@user.username}"

        if params[:print]
          render :print, :layout => 'print'
        else
          render
        end
      end
    end
  end
  
  def galleries
    @user = User.where( :username => params[:username] ).first
    authorize! :galleries, @user
    
    tag = Tag.where( :name_seo => @user.username ).first
    @galleries = Gallery.all.where( :tag => tag ).page( params[:galleries_page] )
    @title = "Galleries of #{@user.username}"

  end

  def scratchpad
    s = params[:user][:scratchpad]
    @current_user.scratchpad = s
    authorize! :scratchpad, @current_user
    
    if @current_user.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    redirect_to organizer_path
  end

  def report
    @report = Report.where( :name_seo => params[:name_seo] ).first
    @user = @report.user
    authorize! :show, @report
    
  end

  def reports
    @user = User.where( :username => params[:username] ).first
    @tag = Tag.where( :name_seo => @user.username ).first
    if @tag.blank?
      flash[:notice] = 'This user has no characteristic tag.'
    end
    @reports = Report.all.where( :tag => @tag ).page( params[:reports_page] )

    respond_to do |format|
      format.html
      format.json do
        render :json => @reports
      end
    end
  end

  # def edit
  def account
    authorize! :account, User.new
    @user = @current_user
    @profiles = @user.user_profiles
    render 'edit', :layout => 'organizer'
  end
  
  def index
    @title = 'All Users'
    @users = User

    unless params[:cityname].blank?
      city = City.where( :cityname => params[:cityname] ).first
      @users = @users.where( :city => city )
    end

    @users = @users.page( params[:users_page] )

    respond_to do |format|
      format.html do
        render :layout => @layout
      end
      format.json do
        render :json => @users
      end
    end
  end
  
  def organizer
    # @reports = Report.where( :user => (current_user || session['current_user']) ).page(1)
    
    @newsitems = @current_user.newsitems.all.order_by( :created_at => :descr ).page( params[:newsitems_page] )
    render :layout => 'organizer'
  end

  def update
    @user = User.find params[:id]
    old_group_id = @user.group_id
    authorize! :update, @user
    params[:user][:group_id] = old_group_id

    if @user.update_attributes params[:user]
      flash[:notice] = 'Success'
      redirect_to organizer_path
    else
      flash[:error] = 'No Luck. ' + @user.errors.inspect
      render :action => :edit, :layout => 'organizer'
    end
    
  end
  
end
