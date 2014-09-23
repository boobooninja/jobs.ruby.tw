class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_my_job, only: [:edit, :update, :destroy, :open, :close]
  before_action :set_job, only: :show

  # GET /jobs
  # GET /jobs.json
  def index
    # @jobs = Job.all
    if params[:user_id]
      @jobs = User.find(params[:user_id]).jobs.recent
    elsif params[:keyword]
      @jobs = Job.online.search(params[:keyword])
    else
      @jobs = Job.online.recent
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    # @job = Job.find(params[:id])

    set_page_title "#{@job.title} | #{@job.company_name} is hiring!"
    set_page_description @job.description
  end

  # GET /jobs/new
  def new
    # @job = Job.new
    @job = current_user.jobs.build
    @job.deadline = Time.zone.now + 90.days
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    # @job = Job.new(job_params)
    @job = current_user.jobs.build(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def preview
    @job = current_user.jobs.build(job_params)
    @job.created_at = Time.now
    @job.valid?

    render layout: false
    # render :preview
  end

  def open
    @job.open
    @job.save!

    redirect_to @job
  end

  def close
    @job.close
    @job.save!

    redirect_to @job
  end

  private

  def find_my_job
    @job = current_user.jobs.find(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_job
    @job = Job.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def job_params
    params.require(:job).permit(:title, :job_type, :occupation, :company_name, :location, :url, :description, :apply_information, :deadline, :user_id, :aasm_state)
  end
end
