class TasksController < ApplicationController
  before_action :setting_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.order(created_at: :desc).page(params[:page]).per(50)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = 'task is registed!'
      redirect_to @task
    else
      flash.now[:danger] = 'failure to regist'
      render :new
    end
  end
  
  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'task is updated!'
      redirect_to @task
    else
      flash.now[:danger] = 'failure to update '
      render :edit
    end
  end

  def destroy
    
    if @task.destroy
      flash[:success] = 'task is deleted!'
      redirect_to tasks_url
    else
      flash.now[:danger] = 'failure to delete '
      render :edit
    end
  end
  
  private

  # Strong Parameter
  
  def setting_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content,:status)
  end
  
end
