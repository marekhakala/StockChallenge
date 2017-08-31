class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :update, :destroy]

  def index
    @stocks = Stock.all.includes(:market_price, :bearer)
    render json: @stocks, status: :ok
  end

  def show
    @stock = Stock.where(id: params[:id]).first
    render json: @stock, status: :ok
  end
 
  def create
    unless stock_params.values.include?("invalid")
      @stock = Stock.new stock_params
      if @stock.save
        render json: @stock, status: :created
      else
        render json: { errors: @stock.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: filtered_invalid_stock_params }, status: :unprocessable_entity
    end
  end

  def update
    if @stock.update stock_params
      render json: @stock, status: :ok
    else
      render json: { errors: @stock.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @stock and @stock.destroy
      render json: { message: "Stock deleted" }, status: :ok
    else
      render json: { errors: @stock.errors.full_messages }, status: :unprocessable_entity
    end
  end

  protected
    def set_stock
      @stock = Stock.find params[:id]
    end

    def stock_params
      params.require(:stock).permit(:name, :bearer_name, :value_cents, :currency)
    end

    def filtered_invalid_stock_params
      output_hash_params = {}
      stock_params.each do |key, value|
        output_hash_params["#{key}"] = ["is invalid"] if value == "invalid"
      end

      return output_hash_params
    end
end
