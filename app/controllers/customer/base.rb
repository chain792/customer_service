class Customer::Base < ApplicationController
  before_action :authorize

  helper_method :current_customer

  protected

  def user_class
    @user_class ||= Customer.to_s.constantize
  end

  private 

  def current_customer
    if customer_id = cookies.signed[:customer_id] || session[:customer_id]
      @current_customer ||= Customer.find_by(id: customer_id)
    end
  end
  
  def authorize
    unless current_customer
      flash.alert = "ログインしてください。"
      redirect_to :customer_login
    end
  end
end