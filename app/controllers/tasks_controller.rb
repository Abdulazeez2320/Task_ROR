class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user


  def index
    @tasks = current_user.tasks
  end

  def show;end

  def new
  @task = Task.new
  @priorities = Task.priorities.keys.map { |p| [p.humanize, p] }
end

def edit
  @priorities = Task.priorities.keys.map { |p| [p.humanize, p] }
end


  def create
  @task = current_user.tasks.build(task_params)
  @priorities = Task.priorities.keys.map { |p| [p.humanize, p] }

  if @task.save
    flash[:notice] = "Task created successfully."
    redirect_to tasks_path
  else
    flash.now[:alert] = "Error creating task."
    render :new
  end
end

  def update
  @priorities = Task.priorities.keys.map { |p| [p.humanize, p] }

  if @task.update(task_params)
    flash[:notice] = "Task updated successfully."
    redirect_to tasks_path
  else
    flash.now[:alert] = "Error updating task."
    render :edit
  end
end

  def destroy
    if @task.destroy
      flash[:notice] = "Task deleted successfully."
      redirect_to tasks_path
    else
      flash[:alert] = "Error deleting task."
      redirect_to tasks_path
    end
  end

  private
  def set_task
   @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :priority)
  end
end
