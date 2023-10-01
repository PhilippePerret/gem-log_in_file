#
# Main method
# 

# @api
# 
# = main =
# 
# @param sevevity [Integer] [Optional]
# @param message  [String] The message to log in the file
# @param options  [Hash|Nil] Options
#   :data       Data for template message (message with %{...})
# 
def logif(*args)
  if args[0].is_a?(Integer)
    severity, message, options = args
    return unless Logif.severity?(severity)
  else
    message, options = args
  end
  options ||= {}    
  LogInFile.write(message, **options) # return true if ok
end

module LogInFile
class << self

  def write(message, **options)
    rf.puts(formated_message(message, **options))
    return true
  end

  def formated_message(message, **options)
    s = message.dup
    s = s % options[:data] if options.key?(:data)
    s = "--- #{Time.now.strftime(LOG_TIME_FORMAT)} #{s}"
    return s
  end

  def open_log
    close
    `open "#{LogInFile.logfile_path}"`    
  end

  def rf
    @rf ||= begin
      File.open(logfile_path, File::APPEND|File::WRONLY|File::CREAT)
    end
  end

  def close
    @rf ||= nil
    rf.close unless @rf.nil?
    @rf = nil
  end

  def remove_log
    close
    File.delete(logfile_path) if File.exist?(logfile_path)
  end

  # Log file path
  # 
  def logfile_path
    @logfile_path ||= File.join(logfile_folder, 'loginfile.log')
  end

  def logfile_folder
    @logfile_folder ||= begin
      if tmp_folder.nil?
        File.expand_path('.')
      else
        tmp_folder
      end
    end
  end

  # Maybe a temp folder
  def tmp_folder
    @tmp_folder ||= find_temporary_folder
  end

  def find_temporary_folder
    curdir = File.expand_path('.')
    ['tmp','temp','temporary','.tmp'].each do |cname|
      pth = File.join(curdir, cname)
      return pth if File.exist?(pth)
    end
    return nil
  end

  LOG_TIME_FORMAT = '%Y %m %d %H:%M:%S'
end #/ << self
end #/ module LogInFile
