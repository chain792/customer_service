class Admin::StaffMembersController < Admin::Base
  def index
    @staff_members = StaffMember.order(:family_name_kana, :given_name_kana).page(params[:page])
  end

  def new
    @staff_member = StaffMember.new
  end

  def edit
    @staff_member = StaffMember.find(params[:id])
  end

  def create
    @staff_member = StaffMember.new(staff_member_params)
    if @staff_member.save
      flash.notice = "職員アカウントを新規登録しました。"
      redirect_to :admin_staff_members
    else
      render "new", status: :unprocessable_entity
    end
  end

  def update
    @staff_member = StaffMember.find(params[:id])
    if @staff_member.update(staff_member_params)
      flash.notice = "職員アカウントを更新しました。"
      redirect_to :admin_staff_members
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    staff_member = StaffMember.find(params[:id])
    if staff_member.deletable?
      staff_member.destroy!
      flash.notice = "職員アカウントを削除しました。"
    else
      flash.alert = "この職員アカウントは削除できません。"
    end
    redirect_to :admin_staff_members
  end

  private 

  def staff_member_params
    params.require(:staff_member).permit(
      :email, :password, :password_confirmation, :family_name, :given_name,
      :family_name_kana, :given_name_kana,
      :start_date, :end_date, :suspended
    )
  end
end
