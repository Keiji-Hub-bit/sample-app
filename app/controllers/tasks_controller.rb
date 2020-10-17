class TasksController < ApplicationController
protect_from_forgery
  
  def index
    @tasks = Task.all
    
  end
  
  def show
    
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new
  end
  
  def create
    # @task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクを新規作成しました。'
      redirect_to tasks_url
    else
      render :new
    end
  end
  
  private
     def task_params
      params.require(:task).permit(:name,:created_at)
     end
end