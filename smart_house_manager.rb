require 'cuba'
require 'mote'
require 'mote/render'
require_relative 'lib/device_type'
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
