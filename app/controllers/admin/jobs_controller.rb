class Admin::JobsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit,:update, :destroy]
  before_action :require_is_admin
  layout "admin"
  def show
   @job = Job.find(params[:id])
  end

  def index
    @jobs = Job.all.paginate(:page => params[:page], :per_page => 6)
  end

  def edit
    @job = Job.find(params[:id])
    @category = Category.all.map{ |c| [c.name, c.id] }
    @location = Location.all.map{ |c| [c.name, c.id] }
  end

  def new
    @job = Job.new
    @categories = Category.all.map{ |c| [c.name, c.id] }
    @locations = Location.all.map{ |c| [c.name, c.id] }
  end

  def create
    @job = Job.new(job_params)
    @job.category_id = params[:category_id]
    @job.location_id = params[:location_id]
     if @job.save
       redirect_to admin_jobs_path
     else
       render :new
     end
   end

   def update
     @job = Job.find(params[:id])
     @job.category_id = params[:category_id]
     @job.location_id = params[:location_id]
      if @job.update(job_params)
        redirect_to admin_jobs_path
      else
        render :edit
      end
    end

    def destroy
      @job = Job.find(params[:id])
      @jod.destroy
      redirect_to admin_jobs_path
    end

    def publish
        @job = Job.find(params[:id])
        @job.publish!
        redirect_to :back
      end

      def hide
        @job = Job.find(params[:id])
        @job.hide!
        redirect_to :back
      end

    private



      def job_params
        params.require(:job).permit(:title, :description, :wage_lower_bound, :wage_upper_bound, :contact_email, :is_hidden, :address, :latitude, :longitude, :category_id, :location_id)
      end
end
