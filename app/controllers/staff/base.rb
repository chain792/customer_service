class Staff::Base < ApplicationController
  protected

  def user_class
    @user_class ||= StaffMember.to_s.constantize
  end
end
