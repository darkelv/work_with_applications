class Admin::UsersController < Admin::BaseController

  def index
    users = User.all
    render locals: {users: users}
  end
end
