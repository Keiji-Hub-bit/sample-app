class TasksController < ApplicationController
protect_from_forgery
before_action :limitation_correct_user,only:[:new]


      def index
          @user =  User.find(params[:user_id])
          @tasks = current_user.tasks.order(created_at: :desc).paginate(page:params[:page])
          
        #   @tasks = current_user.tasks
      end
      
      def show
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
      
      def logged_in_user
       unless logged_in?
         flash[:danger] = "ログインしてください。"
         redirect_to login_url
       end
      end
     def correct_user
        @task = Task.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
     end
     
     def limitation_correct_user
        unless @current_user.id == params[:id].to_i
        flash[:danger] = "他のユーザーのﾀｸｽは作成できません"
        redirect_to root_url
        end    
     end
end
