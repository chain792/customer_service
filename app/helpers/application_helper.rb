module ApplicationHelper
  def document_title
    if @title.present?
      "#{@title} - Baukis2"
    else
      "Baukis2"
    end
  end

  def hour_options
    (0..23).map { |h| [ "%02d" % h, h ] }
  end

  def minute_options
    (0..11)
      .map { |n| n * 5}
      .map { |m| [ "%02d" % m, m ] }
  end
end
