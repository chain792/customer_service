class Staff::PasswordsController < Staff::Base
  def edit
    @form = Staff::ChangePasswordForm.new
  end

  def update
    @form = Staff::ChangePasswordForm.new(staff_member_params)
    staff_member = StaffMember.find(current_staff_member.id)
    if staff_member.valid_password?(@form.current_password) &&
      staff_member.update(password: @form.password, password_confirmation: @form.password_confirmation)
        flash.notice = "パスワードを変更しました。"
        redirect_to :staff_account
    else
      flash.now.alert = "入力に誤りがあります。"
      render "edit", status: :unprocessable_entity
    end
  end

  private 
  
  def staff_member_params
    params.require(:staff_change_password_form).permit(
      :current_password, :password, :password_confirmation
    )
  end
end
