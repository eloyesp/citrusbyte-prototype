require 'cuba'
require 'mote'
require 'mote/render'

Cuba.plugin(Mote::Render)

Admin = Cuba.new do
  on root do
    render 'admin_dashboard', devices: DEVICES
  end

  on 'devices/new' do
    on get do
      render 'device_form'
    end

    on post do
      DEVICES.push name: req.params['name'], controls: []
      res.redirect "/admin/devices/#{ DEVICES.length - 1 }/"
    end
  end

  on 'devices/:id' do |id|
    device = DEVICES[id.to_i]

    on root do
      render 'device', device: device
    end

    on 'controls/new' do
      type = req.params['type']

      on get do
        render "controls/#{ type }_settings", control: {}
      end

      on post do
        control = ControlFactory.create(req.params)
        device[:controls].push(control)
        res.redirect("/admin/devices/#{ id }/")
      end
    end

    on 'controls/:id' do |id|
      control = device[:controls][id.to_i]
      render "controls/#{ control[:type] }_settings", control: control
    end
  end
end

Cuba.define do
  on 'admin' do
    run Admin
  end

  on 'dashboard' do
    render 'mobile_dashboard', devices: DEVICES
  end

  on 'devices/:id' do |id|
    device = DEVICES[id.to_i]
    render 'mobile_device', device: device
  end
end

DEVICES = [
  { name: 'Samsung Audio',
    controls: [{
      name: 'Power',
      type: 'button'
    }, {
      name: 'Volume',
      type: 'slider'
    }, {
      name: 'Playlist',
      type: 'select',
      options: [ 'Lonely Day', 'Soldier Side' ]
    }]
  }, {
    name: 'Sony Audio',
    controls: [{
      name: 'Power',
      type: 'button'
    }, {
      name: 'Volume',
      type: 'slider'
    }, {
      name: 'Playlist',
      type: 'select',
      options: [ 'Lonely Day', 'Soldier Side' ]
    }]
  }
]

module ControlFactory
  module_function

  def create params
    case params['type']
    when 'button'
      create_button params
    else raise "Invalid type #{ params['type'] }"
    end
  end

  def create_button params
    { name: params['name'],
      type: 'button',
      endpoint: params['endpoint'] }
  end
end
