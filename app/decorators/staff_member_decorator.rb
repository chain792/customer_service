class StaffMemberDecorator < ApplicationDecorator
  delegate_all

  def suspended_mark
    suspended? ? h.raw("&#x2611;") : h.raw("&#x2610;")
  end

  def full_name
    "#{family_name} #{given_name}"
  end

  def full_name_kana
    "#{family_name_kana} #{given_name_kana}"
  end

end
