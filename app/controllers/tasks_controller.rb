class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]
  before_action :check_if_admin, only: [:create, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    if @is_admin
      @tasks = Task.all
    else
      @tasks = Task.where(user_id: @person.id) + Task.where(state: 'open')
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
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
    check_if_admin unless task_params[user_id: @person.id] && (task_params[state: 'in progress'] || task_params[state: 'done'])
    decrease_reward if task_params[state: 'failed'] && @task.state != 'failed'
    if @task.update(task_params)
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
      params.require(:task).permit(:description, :reward, :state, :user_id)
    end

    def decrease_reward
      @task.reward -= 1 if @task.reward > 1
    end
end
