class Control < Struct.new(:id, :name, :type, :config)
  CONTROLS = []

  def initialize *args
    super
    self[:config] ||= {}
  end

  def self.create attributes
    id = CONTROLS.length + 1
    control = new id,
      attributes[:name],
      attributes[:type],
      attributes[:config] || {}
    CONTROLS << control
    control
  end

  def self.all
    CONTROLS
  end

  def self.[] id
    CONTROLS[id - 1]
  end

  def update attributes
    attributes.each { |att, val| send(:"#{att}=", val) }
  end
end
