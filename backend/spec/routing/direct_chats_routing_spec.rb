require "rails_helper"

RSpec.describe DirectChatsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/direct_chats").to route_to("direct_chats#index")
    end

    it "routes to #show" do
      expect(get: "/direct_chats/1").to route_to("direct_chats#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/direct_chats").to route_to("direct_chats#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/direct_chats/1").to route_to("direct_chats#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/direct_chats/1").to route_to("direct_chats#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/direct_chats/1").to route_to("direct_chats#destroy", id: "1")
    end
  end
end
