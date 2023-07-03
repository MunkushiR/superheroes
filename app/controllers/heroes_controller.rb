class HeroesController < ApplicationController
  def index
    heroes = Hero.all
    render json: heroes
  end

  def show
    hero = Hero.find_by(id: params[:id])
    if hero
      render json: hero, include: :powers
    else
      render json: { error: 'Hero not found' }, status: :not_found
    end
  end

  def create
    hero = Hero.new(hero_params)
    if hero.save
      render json: hero, status: :created
    else
      render json: { errors: hero.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    hero = Hero.find_by(id: params[:id])
    if hero
      if hero.update(hero_params)
        render json: hero
      else
        render json: { errors: hero.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Hero not found' }, status: :not_found
    end
  end

  def destroy
    hero = Hero.find_by(id: params[:id])
    if hero
      hero.destroy
      render json: { message: 'Hero deleted successfully' }
    else
      render json: { error: 'Hero not found' }, status: :not_found
    end
  end

  private

  def hero_params
    params.require(:hero).permit(:name, :super_name)
  end
end
