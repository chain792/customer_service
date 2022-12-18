class Customer < ApplicationRecord
  authenticates_with_sorcery!

  has_one :home_address, dependent: :destroy
  has_one :work_address, dependent: :destroy

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
end
