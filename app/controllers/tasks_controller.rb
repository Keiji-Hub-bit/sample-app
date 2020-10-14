class TasksController < ApplicationController
  
  protect_from_forgery
  def new
    @task = Task.new
  end
  
  def index
    @task = Task.all
  end
  
  def show
    
  end
 
  def edit
    @task = Task.find(params[:id])
  end
  
  def create
    @task = Task.new(
      name:params[:name],
      user_id: @current_user.id,
      )
    if @task.save
    flash[:notice] = 'タスクを新規作成しました。'
    redirect_to tasks_url
    else
    render :new
    end
  end
end
