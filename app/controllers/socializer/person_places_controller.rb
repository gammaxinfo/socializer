module Socializer
  class PersonPlacesController < ApplicationController
    before_filter :set_person_place, only: [:update, :destroy]

    def create
      @person_place = current_user.adresses.build(params[:person_place])
      @person_place.save!
      redirect_to current_user
    end

    def update
      @person_place.update!(params[:person_place])
      redirect_to current_user
    end

    def destroy
      @person_place.destroy
      redirect_to current_user
    end

    private

    def set_person_place
      @person_place = current_user.places.find(params[:id])
    end
  end
end
