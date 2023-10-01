$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "log_in_file"

require "minitest/autorun"
require 'minitest/reporters'
reporter_options = {
  color: true,          # pour utiliser les couleurs
  slow_threshold: true, # pour signaler les tests trop longs
}
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

# @return log file content or nil if it doesn't exist.
def log_content
  LogInFile.close
  if File.exist?(logpath)
    File.read(logpath)
  else
    nil
  end
end
def logpath
  @logpath ||= File.expand_path('./loginfile.log')
end
