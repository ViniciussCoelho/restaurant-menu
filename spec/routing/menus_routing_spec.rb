require "rails_helper"

RSpec.describe Restaurants::MenusController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "restaurants/1/menus").to route_to("restaurants/menus#index", restaurant_id: "1")
    end

    it "routes to #show" do
      expect(get: "restaurants/1/menus/1").to route_to("restaurants/menus#show", restaurant_id: "1", id: "1")
    end

    it "routes to #create" do
      expect(post: "restaurants/1/menus").to route_to("restaurants/menus#create", restaurant_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "restaurants/1/menus/1").to route_to("restaurants/menus#update", restaurant_id: "1", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "restaurants/1/menus/1").to route_to("restaurants/menus#update", restaurant_id: "1", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "restaurants/1/menus/1").to route_to("restaurants/menus#destroy", restaurant_id: "1", id: "1")
    end
  end
end
