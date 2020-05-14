class Admin::JobsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit,:update, :destroy]
  before_action :require_is_admin
  def show
   @job = Job.find(params[:id])
  end

  def index
    @jobs = Job.all
  end

  def edit
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
     if @job.save
       redirect_to admin_jobs_path
     else
       reden :new
     end
   end

   def update
     @job = Job.find(params[:id])
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



    private



      def job_params
        params.require(:job).permit(:title, :description, :wage_lower_bound, :wage_upper_bound, :contact_email)
      end
end