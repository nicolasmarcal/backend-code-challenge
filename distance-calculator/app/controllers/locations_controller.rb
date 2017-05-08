class LocationsController < ApplicationController
  include ActionController::Serialization

  def distance
    course = Course.new(origin_location: Location.new(name: permited_params[:origin_name]),
                      destiny_location: Location.new(name: permited_params[:destiny_name]),
                      distance: permited_params[:distance])
    if course.save
      render status: :ok
    else
      render json: course.errors, status: :unprocessable_entity
    end
  end

  private

  def permited_params
    params.require(:course).permit(
      :origin_name, :destiny_name, :distance
    )
  end
end