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
    @task = Task.new(name: params[:name])
    if @task.save
      flash[:success] = 'タスクを新規作成しました。'
      redirect_to tasks_url
    else
      render:new
    end
  end
end