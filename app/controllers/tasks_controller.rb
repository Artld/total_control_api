class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]
  before_action :check_if_admin, only: [:create, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks =
    if @is_admin
      if id = params[:filter_by_user_id]
        Task.where(user_id: id)
      elsif state = params[:filter_by_state]
        Task.where(state: state)
      else
        Task.all
      end
    else
      Task.where(user_id: @person.id) + Task.where(state: 'open', user_id: nil)
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    # Restrict access
    check_if_admin unless @task.user_id == @person.id || @task.state == 'open'
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    if @task.save
      render :show, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    state = task_params[:state]
    prev_state = @task.state

    # Restrict access for non-admins unless
    # new state is 'in progress' or 'done' or missed in params
    check_if_admin unless ['in progress', 'done', nil].include?(state) and (
    # task belongs to user
    @task.user_id == @person.id or
    # user assigns task for himself AND task has not owner AND task is open
    task_params[:user_id] == @person.id && @task.user_id.nil? && prev_state == 'open')

    if @task.update(task_params)
      @task.decrease_reward if state == 'failed' && prev_state != 'failed'
      send_reward if state == 'verified' && prev_state != 'verified'
      render :show, status: :ok, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      if @is_admin
        params.require(:task).permit(:description, :reward, :state, :user_id)
      else
        params.require(:task).permit(:state, :user_id)
      end
    end

    def send_reward
      @task.user.get_reward @task.reward
    end
end
