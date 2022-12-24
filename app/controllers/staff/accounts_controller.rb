class Staff::AccountsController < Staff::Base
  def show
    @staff_member = current_staff_member
  end

  def edit
    @staff_member = current_staff_member
  end

  # PATCH
  def confirm
    @staff_member = current_staff_member
    @staff_member.assign_attributes(staff_member_params)
    if @staff_member.valid?
      render action: "confirm", status: :unprocessable_entity
    else
      render action: "edit", status: :unprocessable_entity
    end
  end

  def update
    @staff_member = current_staff_member
    if params[:commit]
      if @staff_member.update(staff_member_params)
        flash.notice = "アカウント情報を更新しました。"
        redirect_to :staff_account
      else
        render "edit", status: :unprocessable_entity
      end
    else
      render "edit", status: :unprocessable_entity
    end
  end

  private 
  
  def staff_member_params
    params.require(:staff_member).permit(
      :email, :family_name, :given_name,
      :family_name_kana, :given_name_kana
    )
  end
end