class PowersController < ApplicationController
    def index
      powers = Power.all
      render json: powers, only: [:id, :name, :description]
    end
  
    def show
      power = Power.find_by(id: params[:id])
  
      if power
        render json: power, only: [:id, :name, :description]
      else
        render json: { error: 'Power not found' }, status: :not_found
      end
    end
  
    def update
      power = Power.find_by(id: params[:id])
  
      if power
        if power.update(power_params)
          render json: power, only: [:id, :name, :description]
        else
          render json: { errors: power.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Power not found' }, status: :not_found
      end
    end
  
    private
  
    def power_params
      params.require(:power).permit(:description)
    end
  end
  