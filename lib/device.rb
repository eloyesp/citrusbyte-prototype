class Device < Struct.new(:id, :name, :controls)
  DEVICES = []

  def self.create attributes
    id = DEVICES.length + 1
    device = new id, attributes[:name], attributes[:controls]
    DEVICES << device
    device
  end

  def self.all
    DEVICES
  end

  def self.[] id
    DEVICES[id - 1]
  end
end

DEVICES_SEED = [
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

DEVICES_SEED.each do |device|
  Device.create device
end
