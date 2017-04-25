require 'cuba'
require 'mote'
require 'mote/render'

Cuba.plugin(Mote::Render)

Cuba.define do
  on root do
    render 'admin_dashboard', devices: DEVICES
  end

  on 'devices/new' do
    on get do
      render 'device_form'
    end

    on post do
      DEVICES.push name: req.params['name'], controls: []
      res.redirect "/devices/#{ DEVICES.length - 1 }"
    end
  end

  on 'devices/:id' do |id|
    device = DEVICES[id.to_i]

    on root do
      render 'device', device: device
    end

    on 'controls/:id' do |id|
      control = device[:controls][id.to_i]
      render 'control', control: control
    end
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
