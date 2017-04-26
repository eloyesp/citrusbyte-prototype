class DeviceType < Struct.new(:id, :name, :controls)
  DEVICE_TYPES = []

  def self.create attributes
    id = DEVICE_TYPES.length + 1
    device_type = new id, attributes[:name], attributes[:controls]
    DEVICE_TYPES << device_type
    device_type
  end

  def self.all
    DEVICE_TYPES
  end

  def self.[] id
    DEVICE_TYPES[id - 1]
  end
end

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

DEVICE_TYPES_SEED.each do |device_type|
  DeviceType.create device_type
end
