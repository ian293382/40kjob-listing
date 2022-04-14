class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy, :favorite]
   before_action :validate_search_key, only: [:search]

  def index

    #目前使用單一條件篩選
      @jobs = case params[:order]

      when 'by_lowe_bound'  #條件一
        Job.published.order('wage_lower_bound DESC').paginate(:page => params[:page], :per_page => 6)
      when 'by_upper_bound' #條件二
        Job.published.order('wage_upper_bound DESC').paginate(:page => params[:page], :per_page => 6)
      when  params[:category].blank?
              @category_id = Category.find_by(name: params[:category]).id
              @jobs = Job.where(:category_id => @category_id).paginate(:page => params[:page], :per_page => 6)
      when  params[:category].blank?
              @location_id = Locatin.find_by(name: params[:location]).id
              @jobs = Job.where(:location_id => @location_id).paginate(:page => params[:page], :per_page => 6)
      else
              Job.published.recent.paginate(:page => params[:page], :per_page => 6)
      end
  end

  def show
    @job = Job.find(params[:id])

    # 使用經緯度兩個欄位的數值，建立 Google Map

    @hash = Gmaps4rails.build_markers(@job) do |job, marker|
      marker.lat job.latitude
      marker.lng job.longitude
    end

    if @job.is_hidden
      flash[:warning] = "This Job already archived"
      redirect_to root_path
    end
  end


   def new
     @job = Job.new
   end

   def create
     @job = Job.new(job_params)
    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end


  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      redirect_to jobs_path ,notice: "update success"
    else
      render :edit
    end
  end

  def destroy
    @job= Job.find(params[:id])
    @job.destroy
    redirect_to jobs_path ,alert: "job delete"
  end


  def add
   @job = Job.find(params[:id])

   if !current_user.is_member_of?(@job)
     current_user.add_favorite!(@job)
   end

   redirect_to :back
  end

  def remove
   @job = Job.find(params[:id])

   if current_user.is_member_of?(@job)
     current_user.remove_favorite!(@job)
   end

   redirect_to :back
  end

  def search
    if @query_string.present?
      #顯示jobs公開職位開始搜尋  若加上location(固定資料搜尋時 則替換Job.joins(:location))
      search_result = Job.published.ransack(@search_criteria).result(:distinct => true)
      @jobs = search_result.recent.paginate(:page => params[:page], :per_page => 5 )
    end
  end



  private
    def job_params
      params.require(:job).permit(:title ,:description, :wage_lower_bound, :wage_upper_bound, :contact_email, :is_hidden, :favorite, :category_id, :location_id)
    end


    protected

     def validate_search_key
       # 去除特殊字符 # 正則運算子
       @query_string = params[:keyword].gsub(/\\|\'|\/|\?/, "") if params[:keyword].present?
       @search_criteria = search_criteria(@query_string)
     end

     def search_criteria(query_string)
     # 篩選多個欄位#
     { :title_or_category_or_company_or_location_cont => query_string }
   end
end
