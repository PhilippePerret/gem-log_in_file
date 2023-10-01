require 'test_helper'

class LogMessagesTest < Minitest::Test

  def setup
    super
  end

  def teardown
    Logif.remove_log
  end

  def test_set_data_to_message
    Logif.remove_log
    assert_nil(log_content)

    # --- test ---
    logif("Un %{c} message.", **{data:{c:"bon"}})

    # --- check ---
    assert_match("Un bon message", log_content)
  end
end #/Minitest
