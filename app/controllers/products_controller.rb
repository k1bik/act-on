# typed: strict

class ProductsController < ApplicationController
  extend T::Sig

  sig { void }
  def index
    location = Location.includes(:products).find(params[:location_id])
    products = location.products.order(created_at: :desc)

    respond_to do |f|
      f.html { render :index, locals: { location:, products: }, layout: "location" }
    end
  end

  sig { void }
  def new
    location = Location.find(params[:location_id])
    product = Product.new

    respond_to do |f|
      f.html { render :new, locals: { location:, product: } }
    end
  end

  sig { void }
  def show
    location = Location.includes(:products).find(params[:location_id])
    product = location.products.find(params[:id])

    respond_to do |f|
      f.html { render :show, locals: { location:, product: } }
    end
  end

  sig { void }
  def create
    location = Location.find(params[:location_id])
    product = Product.new(location:, **product_params)

    respond_to do |f|
      if product.save
        f.turbo_stream do
          render turbo_stream: turbo_stream.update(
            :products,
            partial: "products/products",
            locals: { products: location.products.order(created_at: :desc), location: }
          )
        end
      else
        f.html { render :new, locals: { location:, product: } }
      end
    end
  end

  private

  sig { returns(ActionController::Parameters) }
  def product_params = params.require(:product).permit(:name, :description, :price)
end
