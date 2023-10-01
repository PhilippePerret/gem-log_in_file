module Logif
  NOTICE  = 2
  INFO    = 4
  WARN    = 8
  ERROR   = 16
  ALL     = ERROR|WARN|INFO|NOTICE
class << self


  # @api
  def severity_level=(value)
    value.is_a?(Integer) || raise(ArgumentError.new("Logif.severity_level should be a Integer, not a #{value.class}."))
    @severity_level = value
  end

  # @api
  def remove_log
    LogInFile.remove_log
  end

  # @api
  def open
    LogInFile.open_log
  end
  alias :start :open

  def severity?(value)
    (severity_level & value) > 0
  end

  def severity_level
    @severity_level ||= Logif::ALL
  end

end #/ << self
end
