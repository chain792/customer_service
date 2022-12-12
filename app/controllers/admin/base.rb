class Admin::Base < ApplicationController
  protected

  def user_class
    @user_class ||= Administrator.to_s.constantize
  end
end
