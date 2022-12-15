class StaffMember < ApplicationRecord
  authenticates_with_sorcery!

  has_many :events, class_name: "StaffEvent", dependent: :destroy

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, uniqueness: true

  def active?
    !suspended? && start_date <= Date.today &&
    (end_date.nil? || end_date > Date.today)
  end
end
