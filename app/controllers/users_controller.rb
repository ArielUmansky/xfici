class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :edit, :update, :show]

  def show
  	@user = User.find(params[:id])
  end

  def index
  	@users = User.paginate(page: params[:page])
  end
end
