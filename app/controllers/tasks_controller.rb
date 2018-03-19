class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit, :update, :destroy]
  before_action :setting_task, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'task is registed!'
      redirect_to current_user
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
      redirect_to current_user
    else
      flash.now[:danger] = 'failure to update '
      render :edit
    end
  end

  def destroy
    if @task.destroy
      flash[:success] = 'task is deleted!'
      redirect_to current_user
    else
      flash.now[:danger] = 'failure to delete '
      render :edit
    end
  end
  
  private

  # Strong Parameter
  
  def setting_task
    @task = current_user.tasks.find_by(id: params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content,:status)
  end
  
end
