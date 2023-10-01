require "test_helper"

class LogInFileTest < Minitest::Test

  def setup
    super
  end

  def teardown
    Logif.remove_log
  end

  def test_that_it_has_a_version_number
    refute_nil ::LogInFile::VERSION
  end

end
