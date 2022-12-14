class CustomerDecorator < ApplicationDecorator
  delegate_all

  def full_name
    "#{family_name} #{given_name}"
  end

  def full_name_kana
    "#{family_name_kana} #{given_name_kana}"
  end

  def birthday
    return "" if object.birthday.blank?
    object.birthday.strftime("%Y/%m/%d")
  end

  def gender
    case object.gender
    when "male"
      "男性"
    when "female"
      "女性"
    else
      ""
    end
  end

  def personal_phones
    object.personal_phones.map(&:number)
  end

end
