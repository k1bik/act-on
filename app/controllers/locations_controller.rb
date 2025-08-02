# typed: strict

class LocationsController < ApplicationController
  include TurboRedirect
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
      redirect_to location_products_path(location), turbo_frame: "_top", notice: "Location created successfully"
    else
      render :new, locals: { location: }
    end
  end

  sig { void }
  def edit
    location = Location.find(params[:id])

    respond_to do |f|
      f.html { render :edit, locals: { location: } }
    end
  end

  sig { void }
  def cancel_editing
    location = Location.find(params[:id])

    respond_to do |f|
      f.turbo_stream do
        render turbo_stream: turbo_stream.update(
          "location-address",
          partial: "locations/address",
          locals: { location: }
        )
      end
    end
  end

  sig { void }
  def update
    location = Location.find(params[:id])

    respond_to do |f|
      if location.update(location_params)
        flash.now[:notice] = "Адрес успешно обновлен!"

        f.turbo_stream do
          render turbo_stream: [
            turbo_stream.append(:flash, partial: "shared/flash"),
            turbo_stream.update("location-address", partial: "locations/address", locals: { location: }),
            turbo_stream.update(
              "location-sidebar-#{location.id}",
              partial: "locations/location_sidebar",
              locals: { location: }
            )
          ]
        end
      else
        f.html { render :edit, locals: { location: } }
      end
    end
  end

  private

  sig { returns(ActionController::Parameters) }
  def location_params = params.require(:location).permit(:address)
end
