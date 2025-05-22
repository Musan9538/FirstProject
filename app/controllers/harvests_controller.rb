class HarvestsController < ApplicationController
  before_action :require_user
  before_action :set_harvest, only: [:destroy]
  
  def index
    @harvests = if current_user.is_admin?
      Harvest.all.order(date: :desc)
    else
      current_user.harvests.order(date: :desc)
    end
  end

  def new
    @harvest = Harvest.new
  end

  def create
    @harvest = current_user.harvests.build(harvest_params)
    if @harvest.save
      flash[:notice] = "収穫量を記録しました"
      redirect_to harvests_path
    else
      flash.now[:alert] = "収穫量の記録に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @harvest.destroy
      flash[:notice] = "収穫記録を削除しました"
    else
      flash[:alert] = "収穫記録の削除に失敗しました"
    end
    redirect_to harvests_path
  end

  private

  def set_harvest
    @harvest = if current_user.is_admin?
      Harvest.find(params[:id])
    else
      current_user.harvests.find(params[:id])
    end
  end

  def harvest_params
    params.require(:harvest).permit(:date, :amount)
  end
end
 