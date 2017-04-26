class Device < Struct.new(:id, :type, :name, :ip)
  DEVICES = []

  def self.create attributes
    id = DEVICES.length + 1
    device = new id, attributes[:type], attributes[:name], attributes[:ip]
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
