class StaticPagesController < ApplicationController
  
  
  def top
    @user = User.find_by(id:params[:id])
  end
  
  
end
