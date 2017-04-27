require "cuba/test"
require_relative "../smart_house_manager"

scope do
  test "change volume from the mobile app" do
    post '/devices/1/values', values: { Volume: 100 }
    get '/admin/devices/1/'
    assert last_response.body.include? 'value="100"'
  end

  test "add control to apple TV" do
    post '/admin/device_types/3/controls/new',
      type: "button",
      name: "On/Off",
      config: { endpoint: 'POST localhost' }

    get '/devices/1/'
    assert last_response.body.include? 'On/Off'

    post '/devices/1/values', values: { "On/Off"=>"1" }
    get '/admin/devices/1/'
    assert last_response.body.include? 'checked'
  end
end
