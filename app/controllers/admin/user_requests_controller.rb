class Admin::UserRequestsController < Admin::BaseController
  before_action :set_user_request, only: [
    :edit, :show, :update, :destroy
  ]


  def index
    search_form = AdminUserRequestFilterForm.new(filter_params)
    user_requests = AdminUserRequestsSearcher.new(search_form).perform
    user_requests = user_requests.ordered.page(params[:page]).per(20)
    render locals: { user_requests: user_requests, search_form: search_form }
  end

  def edit
    render locals: {user_request: @user_request}
  end

  def update
    if @user_request.update(user_request_params)
      redirect_to admin_user_request_path(@user_request), notice: "Заявка обновлена"
    else
      render 'edit', locals: {user_request: @user_request}
    end
  end

  def destroy
    @user_request.destroy!
    redirect_to admin_user_requests_path, notice: "Заявка удалена"
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

  def filter_params
    params[:admin_user_request_filter_form] ? params[:admin_user_request_filter_form].permit! : {}
  end
end
