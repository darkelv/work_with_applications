class ApplicationController < ActionController::Base
  layout 'client'
  before_action :authenticate_user!

end
