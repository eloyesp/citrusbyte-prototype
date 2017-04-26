require 'cuba'
require 'mote'
require 'mote/render'
require_relative 'lib/device_type'
require_relative 'lib/device'
require_relative 'lib/control'
require_relative 'initial_config'
require_relative 'lib/admin_app'

Cuba.plugin(Mote::Render)

Cuba.define do
  on root do
    render 'welcome'
  end

  on 'admin' do
    run Admin
  end

  on 'dashboard' do
    render 'mobile_dashboard', device_types: DeviceType.all
  end

  on 'device_types/:id' do |id|
    device_type = DeviceType[id.to_i]
    render 'mobile_device_type', device_type: device_type
  end
end
