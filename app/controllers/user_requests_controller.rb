class UserRequestsController < ApplicationController
  before_action :set_user_request, only: [
    :edit, :show, :update, :destroy
  ]

  def index
    user_requests = current_user.user_requests.with_attached_files.page(params[:page]).per(20)
    render locals: { user_requests: user_requests}
  end

  def new
    user_request = current_user.user_requests.new
    render locals: {user_request: user_request}
  end

  def create
    user_request = current_user.user_requests.new(user_request_params)
    if user_request.save
      redirect_to user_request_path(user_request), notice: "Заявка создана"
    else
      render 'new', locals: {user_request: user_request}
    end
  end

  def edit
    render locals: {user_request: @user_request}
  end

  def update
    if @user_request.update(user_request_params)
      redirect_to user_request_path(@user_request), notice: "Заявка обновлена"
    else
      render 'edit', locals: {user_request: @user_request}
    end
  end

  def destroy
    @user_request.destroy!
    redirect_to user_requests_path, notice: "Заявка удалена"
  end

  def show
    render locals: {user_request: @user_request}
  end

  private

  def set_user_request
    @user_request = UserRequest.find(params[:id])
  end

  def user_request_params
    params.require(:user_request).permit(
      :title, :body, files: []
    )
  end
end
