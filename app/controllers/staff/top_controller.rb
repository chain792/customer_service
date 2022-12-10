class Staff::TopController < ApplicationController
  def index
    raise ActiveRecord::RecordNotFound
  end
end
