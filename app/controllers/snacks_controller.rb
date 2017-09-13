class SnacksController < ApplicationController
  def index
    @machine = Machine.find(params[:machine_id])
    @snacks = Snack.all 
  end
end
