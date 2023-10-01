require 'test_helper'

class LogIfMethodTest < Minitest::Test

  def setup
    super
  end

  def teardown
    Logif.remove_log
  end

  def test_logif_method
    assert method(:logif), "Should respond to :logif"
    assert_silent { logif("Un message") }
  end

  def test_logif_write_nothing_if_bad_severity
    Logif.remove_log
    Logif.severity_level = Logif::NOTICE
    assert_nil( logif(Logif::WARN, "---NO MESSAGE---"), "logif should return false if severity is not good" )
    refute_match("NO MESSAGE", log_content.to_s)
  end

  def test_logif_write_message_if_good_severity
    Logif.remove_log
    Logif.severity_level = Logif::NOTICE    
    assert(logif(Logif::NOTICE, "Un message qui sera écrit."), "logif should return true if severity is good")
    assert_match("Un message qui sera écrit.", log_content)
  end

end 
