require "cuba/test"
require_relative "../smart_house_manager"

scope do
  test "dashboard" do
    get "/"
    assert last_response.body.include?("Smart House Manager")
    assert last_response.body.include?("Dashboard")
  end

  test "device view" do
    get "/devices/1"
    assert last_response.body.include?("Smart House Manager"), 'missing title'
    assert last_response.body.include?('Sony Audio')
  end

  test "slide control view" do
    get "/devices/1/controls/1"
    assert last_response.body.include?("Smart House Manager"), 'missing title'
    assert last_response.body.include?('Volume')
  end

  test "button control view" do
    get "/devices/1/controls/0"
    assert last_response.body.include?('Power')
  end

  test "select control view" do
    get "/devices/1/controls/2"
    assert last_response.body.include?('Playlist')
  end

  test "new device form" do
    get "/devices/new"
    assert last_response.body.include?('Add new device')
  end

  test "submit new device" do
    post "/devices/new", name: 'Test device'
    follow_redirect!
    assert last_response.body.include?('Test device')
  end
end
