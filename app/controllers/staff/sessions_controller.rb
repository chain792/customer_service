class Staff::SessionsController < Staff::Base
  def new
    @form = Staff::LoginForm.new
  end

  def create
    @form = Staff::LoginForm.new(login_form_params)
    staff_member = StaffMember.authenticate(@form.email, @form.password)
    if Staff::Authenticator.new(staff_member).authenticate
      if staff_member.suspended?
        flash.now[:alert] = "アカウントが停止されています。"
        render "new", status: :unprocessable_entity
      else
        auto_login(staff_member)
        redirect_to staff_root_path, notice: "ログインしました。"
      end
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません。"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to staff_root_path, notce: "ログアウトしました。"
  end

  private 

  def login_form_params
    params.require(:staff_login_form).permit(:email, :password)
  end
end
