class TasksController < ApplicationController
protect_from_forgery
before_action :correct_user ,only: [:new,:create,:destroy]
before_action :limitation_correct_user ,only: [:edit]

      def index
          @user = User.find_by(params[:id])
          @tasks = current_user.tasks.order(created_at: :desc).paginate(page:params[:page])
          
        #   @tasks = current_user.tasks
      end
      
      def show
          @user = User.find(params[:user_id])
          @task = Task.find(params[:id])
      end
      
      def edit
          @task = Task.find(params[:id])
          @user = @task.user
      end
 
      def new
          @task = Task.new
      end
      
      def update
         
         @task = Task.find(params[:id])
         if @task.update(task_params)
            @task.save
            flash[:success] = 'タスクを更新しました。'
            redirect_to user_task_url
         else
            render :edit
         end
      end 
      
      def create
          # @task = Task.new(task_params)
         
          @task = current_user.tasks.build(task_params)
          if @task.save
          flash[:success] = 'タスクを新規作成しました。'
          redirect_to user_tasks_url
          else
            render :new
          end
      end    
      
      def destroy
          @task = Task.find(params[:id])
          @task.destroy
          flash[:success] = "投稿を削除しました。"
          redirect_to user_tasks_url
      end
      
  private
      def task_params
         params.require(:task).permit(:name,:created_at,:description,:updated_at)
      end
      
      def logged_in_user
       unless logged_in?
         flash[:danger] = "ログインしてください。"
         redirect_to login_url
       end
      end
      
     def correct_user
        unless @current_user.id == params[:user_id].to_i
        flash[:danger] = "他のユーザーのタスクは作成できません"
         redirect_to(root_url) unless current_user?(@user)
        end
     end
    #     @task = Task.find(params[:id])
    #     redirect_to(root_url) unless current_user?(@user)
    # end
     
     def limitation_correct_user
        unless @current_user.id == params[:user_id].to_i
        flash[:danger] = "他のユーザーのﾀｸｽは編集できません"
        redirect_to(user_tasks_url)
        end    
     end
     
     def set_task
        unless @task = @user.tasks.find_by(id:params[:id])
        flash[:danger] = "他のユーザーのﾀｸｽは作成できません"
        redirect_to root_url
        end
     end
end
