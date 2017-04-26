require "cuba/test"
require_relative "../smart_house_manager"

scope do
  test "dashboard" do
    get "/admin/"
    assert last_response.body.include?("Smart House Manager")
    assert last_response.body.include?("Dashboard")
  end

  test "device_type view" do
    get "/admin/device_types/2/"
    assert last_response.body.include?("Smart House Manager"), 'missing title'
    assert last_response.body.include?('Sony Audio')
  end

  test "slide control view" do
    get "/admin/device_types/1/controls/1"
    assert last_response.body.include?("Smart House Manager"), 'missing title'
    assert last_response.body.include?('Volume')
  end

  test "button control view" do
    get "/admin/device_types/1/controls/0"
    assert last_response.body.include?('Power')
  end

  test "config button control" do
    post "/admin/device_types/1/controls/0", name: "test Power"
    follow_redirect!
    assert last_response.body.include?('test Power')
  end

  test "select control view" do
    get "/admin/device_types/1/controls/2"
    assert last_response.body.include?('Playlist')
  end

  test "new device_type form" do
    get "/admin/device_types/new"
    assert last_response.body.include?('Add new device type')
  end

  test "submit new device_type" do
    post "/admin/device_types/new", name: 'Test device_type'
    follow_redirect!
    assert last_response.body.include?('Test device_type')
  end

  test "new control form" do
    get '/admin/device_types/1/controls/new?type=button'
    assert last_response.body.include?('Configure button control')
  end

  test "add a new button control" do
    post '/admin/device_types/2/controls/new?type=button', endpoint: 'POST example.com/test', name: 'test control'
    follow_redirect!
    assert last_response.body.include?('Sony Audio'), 'redirect to device_type page'
    assert last_response.body.include?('test control'), 'control was created'
  end

  test "mobile dashboard list device_types" do
    get '/dashboard'
    assert last_response.body.include?("Smart House Manager"), 'missing title'
    assert last_response.body.include?('Sony Audio')
  end

  test "mobile dashboard list device_types" do
    get '/device_types/2/'
    assert last_response.body.include?("Smart House Manager"), 'missing title'
    assert last_response.body.include?('Sony Audio')
    assert last_response.body.include?('Volume')
  end
end
