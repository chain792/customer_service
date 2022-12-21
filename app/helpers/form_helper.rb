module FormHelper
  include HtmlBuilder

  def decorated_label(form, name, label_text, options = {})
    form.label(name, label_text, class: options[:required] ? "required" : nil)
  end

  def error_messages_for(form, key)
    markup do |m|
      form.object.errors.full_messages_for(key).each do |message|
        m.div(class: "error-message") do |m|
          m.text message
        end
      end
    end
  end

  def text_field_block(form, name, label_text, options = {})
    markup(:div, class: "input-block") do |m|
      m << decorated_label(form, name, label_text, options)
      m << form.text_field(name, options)
      if options[:maxlength]
        m.span "（#{options[:maxlength]}⽂字以内）", class: "instruction"
      end
      m << error_messages_for(form, name)
    end
  end

  def number_field_block(form, name, label_text, options = {})
    markup(:div) do |m|
      m << decorated_label(form, name, label_text, options)
      m << form.number_field(name, options)
      if options[:max]
        max = number_with_delimiter(options[:max].to_i)
        m.span "（最⼤値: #{max}）", class: "instruction"
      end
      m << error_messages_for(name)
    end
  end

  def email_field_block(form, name, label_text, options = {})
    markup(:div, class: "input-block") do |m|
      m << decorated_label(form, name, label_text, options)
      m << form.email_field(name, options)
      m << error_messages_for(form, name)
    end
  end

  def password_field_block(form, name, label_text, options = {})
    markup(:div, class: "input-block") do |m|
      m << decorated_label(form, name, label_text, options)
      m << form.password_field(name, options)
      m << error_messages_for(form, name)
    end
  end

  def date_field_block(form, name, label_text, options = {})
    markup(:div, class: "input-block") do |m|
      m << decorated_label(form, name, label_text, options)
      m << form.password_field(name, options)
      m << error_messages_for(form, name)
    end
  end

  def drop_down_list_block(form, name, label_text, choices, options = {})
    markup(:div, class: "input-block") do |m|
      m << decorated_label(form, name, label_text, options)
      m << form.select(name, choices, { include_blank: true }, options)
      m << error_messages_for(form, name)
    end
  end

  def full_name_block(form, name1, name2, label_text, options = {})
    markup(:div, class: "input-block") do |m|
      m << decorated_label(form, name1, label_text, options)
      m << form.text_field(name1, options)
      m << form.text_field(name2, options)
      m << error_messages_for(form, name1)
      m << error_messages_for(form, name2)
    end
  end

  def gender_field_block(form)
    markup(:div, class: "radio-buttons") do |m|
      m << decorated_label(form, :gender, "性別")
      m << form.radio_button(:gender, "male")
      m << form.label(:gender_male, "男性")
      m << form.radio_button(:gender, "female")
      m << form.label(:gender_female, "女性")
    end
  end

  def postal_code_block(form, name, label_text, options)
    markup(:div, class: "input-block") do |m|
      m << decorated_label(form, name, label_text, options)
      m << form.text_field(name, options)
      m.span " (7桁の半角数字で入力してください。)", class: "notes"
      m << error_messages_for(form, name)
    end
  end
end
