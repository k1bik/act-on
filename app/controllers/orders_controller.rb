# typed: strict

class OrdersController < ApplicationController
  extend T::Sig

  sig { void }
  def index
    location = Location.find(params[:location_id])
    orders = location.orders.preload(order_items: :product).order(created_at: :desc)

    respond_to do |f|
      f.html { render :index, locals: { orders:, location: }, layout: "location" }
    end
  end
end
