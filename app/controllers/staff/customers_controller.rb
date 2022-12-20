class Staff::CustomersController < Staff::Base
  include StringNormalizer

  def index
    @q = Customer.ransack(normalize_search_params)
    @customers = @q.result(distinct: true).order(:family_name_kana, :given_name_kana).page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer_form = Staff::CustomerForm.new
  end

  def edit
    @customer_form = Staff::CustomerForm.new(Customer.find(params[:id]))
  end

  def create
    @customer_form = Staff::CustomerForm.new
    @customer_form.assign_attributes(params[:form])
    if @customer_form.save
      flash.notice = "顧客を追加しました。"
      redirect_to action: "index"
    else
      flash.now.alert = "入力に誤りがあります。"
      render "new", status: :unprocessable_entity
    end
  end

  def update
    @customer_form = Staff::CustomerForm.new(Customer.find(params[:id]))
    @customer_form.assign_attributes(params[:form])
    if @customer_form.save
      flash.notice = "顧客情報を更新しました。"
      redirect_to action: "index"
    else
      flash.now.alert = "入力に誤りがあります。"
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    customer = Customer.find(params[:id])
    customer.destroy!
    flash.notice = "顧客アカウントを削除しました。"
    redirect_to :staff_customers
  end

  private

  def normalize_search_params
    p = params[:q]
    if p
      p[:family_name_kana_eq] = normalize_as_furigana(p[:family_name_kana_eq])
      p[:given_name_kana_eq] = normalize_as_furigana(p[:given_name_kana_eq])
      p[:addresses_city_eq] = normalize_as_name(p[:addresses_city_eq])
      p[:addresses_postal_code_eq] = normalize_as_postal_code(p[:addresses_postal_code_eq])
      p[:phones_number_for_index_eq] = normalize_as_phone_number(p[:phones_number_for_index_eq]).try(:gsub, /\D/, "")
    end
    p
  end 
end
