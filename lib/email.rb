module Email 
  
  def self.send(to, options)
    log = File.open("log/email.#{Rails.env}.log", "a")
    log.puts "To: " + to
    log.puts "From: " + options[:from]
    log.puts "Subject: " + options[:subject]
    log.puts "Body:"
    log.puts options[:body]
    log.puts "-----------"
    log.close
  end
end
