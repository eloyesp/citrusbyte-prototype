require "cuba/test"
require_relative "../smart_house_manager"

scope do
  test "dashboard" do
    get "/"
    assert last_response.body.include?("Smart House Manager")
    assert last_response.body.include?("Dashboard")
  end
end
