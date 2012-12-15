
class Manager::ReportsController < ManagerController
  
  def index
    @cities = City.list
    @tags = Tag.list
    @reports = Report.fresh.order_by( :created_at => :desc)
    
    if params[:report]

      @reports = params[:report][:is_public] ? @reports.public : @reports.not_public
      @reports = params[:report][:is_done] ? @reports.done : @reports.not_done

      if params[:report]['search_words']
        @reports = @reports.where( :name => /#{params[:report]['search_words']}/ )
      end
      
      if params[:report][:city_id] && params[:report][:city_id] != ''
        @city = City.find params[:report][:city_id]
        @reports = @reports.where( :city => @city )
      else
        @reports = @reports.where( :city => nil )
      end

      if params[:report][:tag_id] && params[:report][:tag_id] != ''
        @city = Tag.find params[:report][:tag_id]
        @reports = @reports.where( :tag => @tag )
      elsif params[:report][:tag_id] == ''
        @reports = @reports.where( :tag => nil )
      end
      
    end
    
    @reports = @reports.page( params[:reports_page] ).per(20)
  end

  def mark_features
    ;
  end
  
  def new
    @report = Report.new

  end
  
  def create
    @report = Report.new params[:report]
    @report.user = current_user

    if @report.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    
    redirect_to manager_reports_path
  end
  
  def edit
    @cities = City.list
    @tags = Tag.list
    @report = Report.find( params[:id] )
  end
  
  def update
    @r = Report.find params[:id]
    if @r.user.blank?
      @r.user = User.where( :username => 'piousbox' ).first
    end
    params[:report][:photo] = nil
    @r.update_attributes params[:report]
    
    if @r.save
      flash[:notice] = 'Success'
    else
      flash[:error] = "No Luck: #{@r.errors.inspect}"
    end
    redirect_to manager_reports_path
  end
  
  def show
    @report = Report.find params[:id]
  end
  
  def destroy
    @g = Report.find params[:id]
    @g.is_trash = 1
    
    if @g.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    
    redirect_to manager_reports_path
  end
    
end
