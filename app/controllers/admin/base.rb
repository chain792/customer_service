class Admin::Base < ApplicationController
  before_action :authorize
  helper_method :current_administrator

  protected

  def user_class
    @user_class ||= Administrator.to_s.constantize
  end

  private

  def current_administrator
    if session[:administrator_id]
      @current_staff_member ||= Administrator.find_by(id: session[:administrator_id])
    end
  end

  def authorize
    unless current_administrator
      flash.alert = "管理者としてログインしてください。"
      redirect_to :admin_login
    end
  end
end
