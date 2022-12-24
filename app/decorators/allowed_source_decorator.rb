class AllowedSourceDecorator < ApplicationDecorator
  delegate_all

  def ip_address
    [octet1, octet2, octet3, wildcard? ? "*" : octet4].join(".")
  end
end
