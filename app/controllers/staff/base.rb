class Staff::Base < ApplicationController
  helper_method :current_staff_member

  protected

  def user_class
    @user_class ||= StaffMember.to_s.constantize
  end

  private

  def current_staff_member
    if session[:staff_member_id]
      @current_staff_member ||= StaffMember.find_by(id: session[:staff_member_id])
    end
  end
end
