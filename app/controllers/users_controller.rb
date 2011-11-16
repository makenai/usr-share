class UsersController < ApplicationController

  before_filter :authenticate_admin!

  def index
    @users = User.page( params[:page] )
  end

end
