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
          flash.now[:notice] = "Продукт успешно добавлен!"
          render turbo_stream: [
            turbo_stream.append(:flash, partial: "shared/flash"),
            turbo_stream.update(:modal, nil),
            turbo_stream.update(
              :products,
              partial: "products/products",
              locals: { products: location.products.order(created_at: :desc), location: }
            )
          ]
        end
      else
        f.html { render :new, locals: { location:, product: } }
      end
    end
  end

  sig { void }
  def update_name = handle_product_update(:product_name)
  sig { void }
  def update_price = handle_product_update(:product_price)
  sig { void }
  def update_description = handle_product_update(:product_description)

  sig { void }
  def edit_name = handle_edit_form(:product_name)
  sig { void }
  def edit_price = handle_edit_form(:product_price)
  sig { void }
  def edit_description = handle_edit_form(:product_description)

  sig { void }
  def cancel_editing_name = handle_cancel_editing(:product_name)
  sig { void }
  def cancel_editing_price = handle_cancel_editing(:product_price)
  sig { void }
  def cancel_editing_description = handle_cancel_editing(:product_description)

  private

  sig { params(target: Symbol).void }
  def handle_product_update(target)
    location, product = find_location_and_product

    respond_to do |f|
      if product.update(product_params)
        f.turbo_stream do
          flash.now[:notice] = "Успешно обновлено!"
          render turbo_stream: [
            turbo_stream.append(:flash, partial: "shared/flash"),
            turbo_stream.update(target, partial: "products/#{target}", locals: { product:, location: }),
            turbo_stream.update(
              "product_card_#{product.id}", partial: "products/product_card", locals: { product:, location: }
            )
          ]
        end
      else
        f.turbo_stream do
          render turbo_stream: turbo_stream.update(
            target,
            partial: "products/edit_#{target}_form",
            locals: { location:, product: }
          )
        end
      end
    end
  end

  sig { params(target: Symbol).void }
  def handle_edit_form(target)
    location, product = find_location_and_product

    respond_to do |f|
      f.turbo_stream do
        render turbo_stream: turbo_stream.update(
          target,
          partial: "products/edit_#{target}_form",
          locals: { location:, product: }
        )
      end
    end
  end

  sig { params(target: Symbol).void }
  def handle_cancel_editing(target)
    location, product = find_location_and_product

    respond_to do |f|
      f.turbo_stream do
        render turbo_stream: turbo_stream.update(target, partial: "products/#{target}", locals: { product:, location: })
      end
    end
  end

  sig { returns([ Location, Product ]) }
  def find_location_and_product
    location = Location.find(params[:location_id])
    product = location.products.find(params[:id])

    [ location, product ]
  end

  sig { returns(ActionController::Parameters) }
  def product_params = params.require(:product).permit(:name, :description, :price)
end
