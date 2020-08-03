class Admin::UsersController < Admin::BaseController

  def index
    search_form = AdminUserFilterForm.new(filter_params)
    users = AdminUsersSearcher.new(search_form).perform
    users = users.ordered.page(params[:page]).per(20)
    render locals: { users: users, search_form: search_form }
  end

  def new
    render locals: {user: User.new}
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to admin_users_path
    else
      render locals: { user: user }
    end
  end

  def edit
    user = User.find(params[:id])
    render locals: { user: user }
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to admin_users_path
    else
      render action: 'edit', locals: { user: user }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :role)
  end

  def filter_params
    params[:admin_user_filter_form] ? params[:admin_user_filter_form].permit! : {}
  end
end
