class UsersController < ApplicationController
  protect_from_forgery
  before_action :set_user,only:[:show,:edit,:destroy]
  before_action :logged_in_user,only: [:show,:edit,:update,:destroy]
  before_action :correct_user,only:[:edit,:update]
  before_action :admin_or_correct_user,only:[:show,:edit,:update]
  before_action :admin_user,only: [:new]
  before_action :admin_user_index,only: [:index]

  
  def index
         @users = User.paginate(page:params[:page])
    
  end
  
  def show
     
  end

  def new
        @user = User.new
  end
  
  def create
        @user = User.new(user_params)
          if @user.save
            log_in @user
            flash[:success] = '新規作成に成功しました。'
            redirect_to @user
          else
            render :new
        
          end
  end
  
  def edit
       
  end
  
  def update
       
     if @user.update_attributes(user_params)
        @user.save
        flash[:success] = "ユーザー情報を更新しました"
        redirect_to @user
     else
        render :edit
     end
  end  
  
   def destroy
        @user.destroy
        flash[:success] = "#{@user.name}のデータを削除しました。"
        redirect_to users_url
   end
  
  private
  
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def set_user
        @user = User.find(params[:id])
    end
    
    def logged_in_user
         unless logged_in?
           flash[:danger] = "ログインしてください。"
           redirect_to login_url
         end
    end
    
    def correct_user
        redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to user_url(current_user) unless current_user.admin?
      flash[:danger] = "既にログインしています。"
    end
    
    def admin_user_index
      redirect_to (root_url) unless current_user.admin?
    end
    

    def admin_or_correct_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user) ||  current_user.admin?
        flash[:danger] = "編集権限がありません。"
        redirect_to(root_url)
      end
    end
end