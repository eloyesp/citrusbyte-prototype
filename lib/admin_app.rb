Admin = Cuba.new do
  on root do
    render 'admin_dashboard', device_types: DeviceType.all, devices: Device.all
  end

  on 'devices' do
    on 'new' do
      on get do
        render 'admin/devices/new', device_types: DeviceType.all
      end

      on post do
        Device.create(
          name: req.params['name'],
          type: DeviceType[req.params['type'].to_i],
          ip: req.params['ip']
        )
        res.redirect '/admin/'
      end
    end

    on ':id' do |device_id|
      device = Device[device_id.to_i]

      on root do
        render 'admin/devices/show', device: device
      end

      on 'values' do
        device[:values].merge! req.params['values']
        res.redirect "/admin/devices/#{ device_id }/"
      end
    end
  end

  on 'device_types/new' do
    on get do
      render 'device_type_form'
    end

    on post do
      device_type = DeviceType.create name: req.params['name'], controls: []
      res.redirect "/admin/device_types/#{ device_type.id }/"
    end
  end

  on 'device_types/:id' do |device_type_id|
    device_type = DeviceType[device_type_id.to_i]

    on root do
      render 'device_type', device_type: device_type
    end

    on 'controls/new' do
      type = req.params['type']

      on get do
        render "controls/#{ type }_settings", control: Control.new
      end

      on post do
        control = Control.create(
          name:   req.params['name'],
          type:   req.params['type'],
          config: req.params['config'])
        device_type[:controls].push(control)
        res.redirect("/admin/device_types/#{ device_type_id }/")
      end
    end

    on 'controls/:id' do |id|
      control = Control[id.to_i]

      on get do
        render "controls/#{ control[:type] }_settings", control: control
      end

      on post do
        control.update(name: req.params['name'],
                       config: req.params['config'])
        res.redirect "/admin/device_types/#{ device_type_id }/"
      end
    end
  end
end
