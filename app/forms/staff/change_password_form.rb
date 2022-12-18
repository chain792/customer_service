class Staff::ChangePasswordForm
  include ActiveModel::Model

  attr_accessor :current_password, :password, :password_confirmation
end
