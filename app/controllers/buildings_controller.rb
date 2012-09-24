class BuildingsController < ApplicationController
  def index
    @buildings = Building.all
    render json: @buildings
  end

  def show
    @building = Building.find(params[:id])
    
    if stale?(@building)
      render json: @building
    end
  end
end