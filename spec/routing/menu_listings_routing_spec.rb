require "rails_helper"

RSpec.describe Menus::MenuListingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "menus/1/menu_listings").to route_to("menus/menu_listings#index", menu_id: "1")
    end

    it "routes to #show" do
      expect(get: "menus/1/menu_listings/1").to route_to("menus/menu_listings#show", menu_id: "1", id: "1")
    end

    it "routes to #create" do
      expect(post: "menus/1/menu_listings").to route_to("menus/menu_listings#create", menu_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "menus/1/menu_listings/1").to route_to("menus/menu_listings#update", menu_id: "1", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "menus/1/menu_listings/1").to route_to("menus/menu_listings#update", menu_id: "1", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "menus/1/menu_listings/1").to route_to("menus/menu_listings#destroy", menu_id: "1", id: "1")
    end
  end
end
