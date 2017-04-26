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
    render 'mobile_dashboard', devices: Device.all
  end

  on 'devices/:id' do |id|
    device = Device[id.to_i]

    on root do
      render 'mobile_device', device: device
    end

    on 'values', post do
      device[:values].merge! req.params['values']
      res.redirect "/devices/#{ id }/"
    end
  end
end
