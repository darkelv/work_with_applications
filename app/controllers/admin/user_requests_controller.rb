class Admin::UserRequestsController < Admin::BaseController

  def index
    user_requests = current_user.user_requests.with_attached_files.page(params[:page]).per(20)
    render locals: { user_requests: user_requests}
  end
end
