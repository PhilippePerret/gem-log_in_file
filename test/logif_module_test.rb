require 'test_helper'

class LogifModuleTest < Minitest::Test

  def setup
    super
  end

  def teardown
    Logif.remove_log
  end


  def test_module_exists
    assert defined?(Logif), "Logif module should exist"
  end

  def test_module_constants_exists
    assert defined?(Logif::ERROR), "Logif::ERROR constant should exist"
    assert defined?(Logif::WARN), "Logif::WARN constant should exist"
    assert defined?(Logif::INFO), "Logif::INFO constant should exist"
    assert defined?(Logif::NOTICE), "Logif::NOTICE constant should exist"
  end

  def test_severity_level_equal_method
    assert_respond_to( Logif, :severity_level=)
    assert_equal(1, Logif.method(:severity_level=).parameters.count, "Logif.severity_level= should wait for 1 parameter.")
    
    [nil, "mauvais", {pas:"bon"}, self].each do |value|
      err = assert_raises(ArgumentError) { Logif.severity_level = value }
      assert_equal "Logif.severity_level should be a Integer, not a #{value.class}.", err.message
    end
  end

  def test_severity_level_method
    assert_respond_to( Logif, :severity_level)
    assert_instance_of Integer, Logif.severity_level
    Logif.severity_level = 12
    assert_equal(12, Logif.severity_level, "Logif.severity_level should return the right value.")
  
    Logif.severity_level = Logif::INFO|Logif::ERROR
    expected  = 20
    actual    = Logif.severity_level
    assert_equal(expected, actual, "Logif.severity_level should equal #{expected}. It is #{actual}")
  end

  def test_severity_predicate
    assert_respond_to(Logif, :severity?)

    Logif.severity_level = Logif::ALL
    assert(Logif.severity?(4), "Logif.severity? should be true when parameter is less then expected severity")
  
    Logif.severity_level = Logif::NOTICE
    refute(Logif.severity?(Logif::WARN), "Logif.severity? should be false when parameter si greater than expected severity")
  end

  def test_respond_to_remove_log
    assert_respond_to(Logif, :remove_log)
  end
  def test_remove_log
    Logif.remove_log
    refute File.exist?(LogInFile.logfile_path)
    s = "Message at #{Time.now.to_i}"
    assert_silent { logif(s) }
    assert File.exist?(LogInFile.logfile_path)
    # --- Test ---
    Logif.remove_log
    # --- Check ---
    refute File.exist?(LogInFile.logfile_path)
  end

  # --- #open ---

  def test_respond_to_open
    assert_respond_to Logif, :open
  end

  def test_respond_to_start # alias of :open
    assert_respond_to Logif, :start
  end

  # 
  # def test_open
  #   Logif.severity_level = Logif::ALL
  #   logif("A message to make the log file existing.")
  #   assert_silent { Logif.open }
  # end

end 
