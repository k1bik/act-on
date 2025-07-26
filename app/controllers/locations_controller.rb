# typed: strict

class LocationsController < ApplicationController
  extend T::Sig

  sig { void }
  def new
    location = Location.new

    respond_to do |f|
      f.html { render :new, locals: { location: } }
    end
  end

  sig { void }
  def create
    location = Location.new(location_params)

    if location.save
      redirect_to root_path, notice: "Location created successfully"
    else
      render :new, locals: { location: }
    end
  end

  private

  sig { returns(ActionController::Parameters) }
  def location_params = params.require(:location).permit(:address)
end
