class TasksController < ApplicationController
  protect_from_forgery
  def index
  @tasks = Task.all
  end
  
  def new
   @task = Task.new
  end
  
  def show
  end
 
  def edit
  end
  
  def create
    @task = Task.new(name:params[:name])
    @task.save
    redirect_to tasks_url 
  end
end
