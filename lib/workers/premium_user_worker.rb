require File.expand_path(File.join('..', 'user_worker'), __FILE__)

class PremiumUserWorker
  @queue = :high
  extend UserWorker
end