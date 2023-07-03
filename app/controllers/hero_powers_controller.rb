class HeroPowersController < ApplicationController
    def create
      hero = Hero.find_by(id: params[:hero_id])
      power = Power.find_by(id: params[:power_id])
  
      if hero && power
        hero_power = HeroPower.new(hero: hero, power: power, strength: params[:strength])
  
        if hero_power.save
          render_hero_with_powers(hero)
        else
          render json: { errors: hero_power.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Hero or Power not found' }, status: :not_found
      end
    end
  
    private
  
    def render_hero_with_powers(hero)
      render json: hero, only: [:id, :name, :super_name], include: { powers: { only: [:id, :name, :description] } }
    end
  end
  