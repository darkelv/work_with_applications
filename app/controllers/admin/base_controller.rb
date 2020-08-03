class Admin::BaseController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :check_admin_role!

  protected

  def check_admin_role!
    raise CanCan::AccessDenied unless current_user.present? && current_user.employee?
  end
end
