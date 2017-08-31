require 'rails_helper'

RSpec.describe StocksController, type: :controller do

  let(:stock) { FactoryGirl.create(:stock, :demo) }
  let(:bearer) { FactoryGirl.create(:bearer, :demo) }
  let(:bearer_second) { FactoryGirl.create(:bearer, :demo_second) }
  let(:market_price) { FactoryGirl.create(:market_price, :demo) }

  describe "GET /stocks" do
    it "should return list with stocks" do
      5.times { |index| FactoryGirl.create(:stock, name: "Stock #{index}",
       bearer: bearer, market_price: market_price) }

      get :index, as: :json
      expect(response).to have_http_status(200)
      json_data = JSON.parse(response.body)

      expect(json_data[0]["name"]).to eq("Stock 0")

      expect(json_data[0]["bearer"]["id"]).to eq(1)
      expect(json_data[0]["bearer"]["name"]).to eq("Me")

      expect(json_data[0]["market_price"]["id"]).to eq(1)
      expect(json_data[0]["market_price"]["currency"]).to eq("EUR")
      expect(json_data[0]["market_price"]["value_cents"]).to eq(1939)

      expect(json_data.count).to eq(5)
    end
  end

  describe "POST /stocks" do
    context "with valid data" do
      it "should return stock and 201 created OK" do
        stock_params = { stock: { name: "Alphabet", bearer_name: "Greg Snowden",
           value_cents: 1939, currency: "EUR" } }
        post :create, as: :json, params: stock_params

        expect(response).to have_http_status(201)
        json_data = JSON.parse(response.body)

        expect(json_data["name"]).to eq(stock_params[:stock][:name])

        expect(json_data["bearer"]["id"]).to eq(1)
        expect(json_data["bearer"]["name"]).to eq(stock_params[:stock][:bearer_name])

        expect(json_data["market_price"]["id"]).to eq(1)
        expect(json_data["market_price"]["currency"]).to eq(stock_params[:stock][:currency])
        expect(json_data["market_price"]["value_cents"]).to eq(stock_params[:stock][:value_cents])

        expect(Stock.count).to eq(1)
        expect(Bearer.count).to eq(1)
        expect(MarketPrice.count).to eq(1)
      end
    end

    context "with invalid data" do
      it "should return 422 and fail to save" do
        stock_params = { stock: { name: "invalid", bearer_name: "invalid", value_cents: 1939, currency: "EUR" } }
        post :create, method: :post, as: :json, params: stock_params
        response_body_content = { "errors" => { "name" => ["is invalid"], "bearer_name" => ["is invalid"] }}

        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)).to eq(response_body_content)
        expect(Stock.count).to eq(0)
        expect(Bearer.count).to eq(0)
        expect(MarketPrice.count).to eq(0)
      end
    end
  end

  describe "PATCH /stocks/:id" do
    context "with different bearer" do
      it "should create new bearer but keep market price" do
        stock_object = stock
        stock_params = { stock: { bearer_name: "Test" }, id: stock_object.id }
        patch :update, as: :json, params: stock_params

        expect(response).to have_http_status(200)
        json_data = JSON.parse(response.body)

        expect(json_data["name"]).to eq(stock_object.name)
        expect(json_data["bearer"]["name"]).to eq(stock_params[:stock][:bearer_name])
        expect(json_data["market_price"]["currency"]).to eq(stock_object.market_price.currency)
        expect(json_data["market_price"]["value_cents"]).to eq(stock_object.market_price.value_cents)

        expect(Stock.count).to eq(1)
        expect(Bearer.count).to eq(2)
        expect(MarketPrice.count).to eq(1)
      end
    end

    context "with different market price" do
      it "should create new market price but keep bearer" do
        stock_object = stock
        stock_params = { stock: { value_cents: 698, currency: stock_object.market_price.currency }, id: stock_object.id }
        patch :update, as: :json, params: stock_params

        expect(response).to have_http_status(200)
        json_data = JSON.parse(response.body)

        expect(json_data["name"]).to eq(stock_object.name)
        expect(json_data["bearer"]["name"]).to eq(stock_object.bearer.name)
        expect(json_data["market_price"]["currency"]).to eq(stock_object.market_price.currency)
        expect(json_data["market_price"]["value_cents"]).to eq(stock_params[:stock][:value_cents])

        expect(Stock.count).to eq(1)
        expect(Bearer.count).to eq(1)
        expect(MarketPrice.count).to eq(2)
      end
    end

    context "with existing bearer" do
      it "should reference existing bearer to stock" do
        stock_object = stock
        bearer_exist = bearer_second

        stock_params = { stock: { bearer_name: bearer_exist.name }, id: stock_object.id }
        patch :update, as: :json, params: stock_params

        expect(response).to have_http_status(200)
        expect(Stock.find(1).bearer.name).to eq(bearer_exist.name)

        expect(Stock.count).to eq(1)
        expect(Bearer.count).to eq(2)
        expect(MarketPrice.count).to eq(1)
      end
    end
  end

  describe "DELETE /stocks/:id" do
    context "with different bearer" do
      it "should create new bearer but keep market price" do
        stock_object = stock
        delete :destroy, as: :json, params: { id: stock_object.id }

        expect(response).to have_http_status(200)
        expect(Stock.count).to eq(0)
        expect(Bearer.count).to eq(1)
        expect(MarketPrice.count).to eq(1)
      end
    end
  end
end
