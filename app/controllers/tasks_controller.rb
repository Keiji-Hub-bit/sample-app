class TasksController < ApplicationController
protect_from_forgery
  
      def index
          @tasks = Task.all
        
      end
      
      def show
          @task = Task.find(params[:id])
      end
      
      def edit
          @task = Task.find(params[:id])
      end
      
      def new
          @task = Task.new
      end
      
      def update
          @task = Task.find(params[:id])
          if @task.update(task_params)
          flash[:success] = 'タスクを更新しました。'
           redirect_to task_url
          else
           render :edit
          end
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
      
      def destroy
          @task = Task.find(params[:id])
          @task.destroy
           flash[:success] = "投稿を削除しました。"
          redirect_to tasks_url
      end
      
  private
      def task_params
         params.require(:task).permit(:name,:created_at,:description,:updated_at)
      end
end