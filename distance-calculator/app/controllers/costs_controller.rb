class CostsController < ApplicationController
  include ActionController::Serialization

  def show
    render_cached_json("cost_api_#{permited_params[:origin]}_#{permited_params[:destination]}_#{permited_params[:weight]}30") do
      cost = CostService.new(permited_params[:origin], permited_params[:destination], permited_params[:weight])

      if cost.valid?
        render json: cost.cost_and_path, status: :ok
      else
        render json: cost.errors, status: :unprocessable_entity
      end
    end
  end

  private

  def render_cached_json(cache_key, opts = {}, &block)
    opts[:expires_in] ||= 1.second

    expires_in(opts[:expires_in], :public => true)

    data = Rails.cache.fetch(cache_key, {raw: true}.merge(opts)) do
      block.call
    end
  end

  def permited_params
    params.require(:cost).permit(
      :origin, :destination, :weight
    )
  end
end