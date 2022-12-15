class Staff::SessionsController < Staff::Base
  skip_before_action :authorize

  def new
    @form = Staff::LoginForm.new
  end

  def create
    @form = Staff::LoginForm.new(login_form_params)
    staff_member = StaffMember.authenticate(@form.email, @form.password)
    if Staff::Authenticator.new(staff_member).authenticate
      if staff_member.suspended?
        staff_member.events.create!(type: "rejected")
        flash.now[:alert] = "アカウントが停止されています。"
        render "new", status: :unprocessable_entity
      else
        session[:staff_member_id] = staff_member.id
        session[:last_access_time] = Time.current
        staff_member.events.create!(type: "logged_in")
        redirect_to staff_root_path, notice: "ログインしました。"
      end
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません。"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    if current_staff_member
      current_staff_member.events.create!(type: "logged_out")
    end
    session.delete(:staff_member_id)
    redirect_to staff_root_path, notice: "ログアウトしました。"
  end

  private 

  def login_form_params
    params.require(:staff_login_form).permit(:email, :password)
  end
end
