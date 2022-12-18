class ApplicationDecorator < Draper::Decorator
  def created_at
    object.created_at.try(:strftime, "%Y/%m%d")
  end

  def updated_at
    object.updated_at.try(:strftime, "%Y/%m%d")
  end
end
