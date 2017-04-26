require 'cuba'
require 'mote'
require 'mote/render'
require_relative 'lib/device'

Cuba.plugin(Mote::Render)

Admin = Cuba.new do
  on root do
    render 'admin_dashboard', devices: Device.all
  end

  on 'devices/new' do
    on get do
      render 'device_form'
    end

    on post do
      device = Device.create name: req.params['name'], controls: []
      res.redirect "/admin/devices/#{ device.id }/"
    end
  end

  on 'devices/:id' do |device_id|
    device = Device[device_id.to_i]

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
        res.redirect("/admin/devices/#{ device_id }/")
      end
    end

    on 'controls/:id' do |id|
      control = device[:controls][id.to_i]

      on get do
        render "controls/#{ control[:type] }_settings", control: control
      end

      on post do
        control.merge!(name: req.params['name'])
        res.redirect "/admin/devices/#{ device_id }/"
      end
    end
  end
end

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
    render 'mobile_device', device: device
  end
end

module ControlFactory
  module_function

  def create params
    case params['type']
    when 'button'
      create_button params
    when 'slider'
      create_slider params
    when 'select'
      create_select params
    else raise "Invalid type #{ params['type'] }"
    end
  end

  def create_button params
    { name: params['name'],
      type: 'button',
      endpoint: params['endpoint'] }
  end

  def create_select params
    { name: params['name'],
      type: 'select',
      endpoint: params['endpoint'],
      options: ['foo', 'bar'] }
  end

  def create_slider params
    { name: params['name'],
      type: 'slider',
      endpoint: params['endpoint'] }
  end

end
