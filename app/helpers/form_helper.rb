module FormHelper
  include HtmlBuilder

  def error_messages_for(form, key)
    markup do |m|
      form.object.errors.full_messages_for(key).each do |message|
        m.div(class: "error-message") do |m|
          m.text message
        end
      end
    end
  end
end
