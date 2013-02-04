module UserWorker
  def perform(user_id)
    user = User.find(user_id)
    if user
      user.increment!(:counter) # do your something
      Resque.enqueue(self, user_id) if user.active
    end
  end
end
