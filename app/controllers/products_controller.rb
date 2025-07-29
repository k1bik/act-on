# typed: strict

class ProductsController < ApplicationController
  extend T::Sig
  layout "location"

  sig { void }
  def index
    location = Location.includes(:products).find(params[:location_id])
    products = location.products.order(created_at: :desc)

    respond_to do |f|
      f.html { render :index, locals: { location:, products: } }
    end
  end
end
