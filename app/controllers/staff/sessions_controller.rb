class Staff::SessionsController < ApplicationController
  def new
    @form = Staff::LoginForm.new
  end

  def create
    @form = Staff::LoginForm.new(login_form_params)
    staff_member = StaffMember.authenticate(@form.email, @form.password)
    if Staff::Authenticator.new(staff_member).authenticate
      if staff_member.suspended?
        flash.now.alert = "アカウントが停止されています。"
        render "new", status: :unprocessable_entity
      else
        flash.notice = "ログインが成功しました。"
        auto_login(staff_member)
        redirect_to staff_root_path
      end
    else
      flash.now.alert = "ログインが失敗しました。"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    logout
    flash.notice = "ログアウトしました。"
    redirect_to staff_root_path
  end

  private 

  def login_form_params
    params.require(:staff_login_form).permit(:email, :password)
  end
end
