class Control < Struct.new(:id, :name, :type, :config)
  CONTROLS = []

  def initialize *args
    super
    self[:config] ||= {}
  end

  # keep track of subclasses to find an appropiate control type
  def self.inherited subclass
    @control_types ||= {}
    subtype = subclass.name.gsub(/Control$/, '').downcase
    @control_types[subtype] = subclass
  end

  def self.create attributes
    id = CONTROLS.length + 1

    control_type = @control_types[attributes[:type]] || self

    control = control_type.new id,
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

class SelectControl < Control
  def initialize *arguments
    super
    self[:config][:options] = ['foo', 'bar']
  end
end
