require File.expand_path(File.join('..', 'user_worker'), __FILE__)

class BasicUserWorker
  @queue = :low
  extend UserWorker
end
