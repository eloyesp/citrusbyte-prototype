DEVICE_TYPES_SEED = [
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
      config: {
        options: [ 'Lonely Day', 'Soldier Side' ]
      }
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
      config: {
        options: [ 'Lonely Day', 'Soldier Side' ]
      }
    }]
  }, {
    name: 'Apple TV',
    controls: [{
      name: 'Power',
      type: 'button'
    }, {
      name: 'Brightness',
      type: 'slider'
    }, {
      name: 'Volume',
      type: 'slider'
    }]
  }, {
    name: 'Citrus Lights',
    controls: [{
      name: 'On/Off',
      type: 'button'
    }]
  }
]

DEVICE_TYPES_SEED.each do |device_type|
  controls = device_type[:controls].map! { |control| Control.create(control) }
  DeviceType.create device_type
end
