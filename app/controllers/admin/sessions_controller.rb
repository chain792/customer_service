class Admin::SessionsController < Admin::Base
  def new
    @form = Admin::LoginForm.new
  end

  def create
    @form = Admin::LoginForm.new(login_form_params)
    administrator = Administrator.authenticate(@form.email, @form.password)
    if administrator
      if administrator.suspended?
        flash.now[:alert] = "アカウントが停止されています。"
        render "new", status: :unprocessable_entity
      else
        auto_login(administrator)
        redirect_to admin_root_path, notice: "ログインしました。"
      end
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません。"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to admin_root_path, notce: "ログアウトしました。"
  end

  private 

  def login_form_params
    params.require(:admin_login_form).permit(:email, :password)
  end
end
