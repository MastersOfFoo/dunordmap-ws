require_relative "application_controller"

class BuildingsController < ApplicationController
  def index
    lat = params[:lat]
    lon = params[:lon]
    @buildings = (lat && lon) ? Building.near(lat, lon) : Building.all
    render json: @buildings
  end

  def show
    @building = Building.find(params[:id])

    if stale?(@building)
      render json: @building
    end
  end
end
