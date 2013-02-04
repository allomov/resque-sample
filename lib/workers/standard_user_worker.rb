require File.expand_path(File.join('..', 'user_worker'), __FILE__)

class StandardUserWorker
  @queue = :normal
  extend UserWorker
end
