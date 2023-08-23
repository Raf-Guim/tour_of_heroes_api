# frozen_string_literal: true

# Creating Api::HeroesController is the same as creating a module for Api and then nest Heroscontroller inside of it

# Api
module Api
  # HeroesController
  class HeroesController < ApplicationController
    include Authenticable

    before_action :authenticate_with_token
    before_action :set_hero, only: %i[show update destroy]

    # GET /heroes
    def index
      # @heroes = Hero.all.sorted_by_name
      @heroes = Hero.by_token(@token).search(params[:term]).sorted_by_name

      render json: @heroes
    end

    # GET /heroes/1
    def show
      render json: @hero
    end

    # POST /heroes
    def create
      @hero = Hero.new(hero_params.to_h.merge!({ token: @token }))

      if @hero.save
        render json: @hero, status: :created, location: api_hero_url(@hero)
      else
        render json: @hero.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /heroes/1
    def update
      if @hero.update(hero_params)
        render json: @hero
      else
        render json: @hero.errors, status: :unprocessable_entity
      end
    end

    # DELETE /heroes/1
    def destroy
      @hero.destroy
    end

    private

    def set_hero
      @hero = Hero.by_token(@token).find(params[:id])
    end

    def hero_params
      params.require(:hero).permit(:name)
    end
  end
end
