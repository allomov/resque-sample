require File.expand_path(File.join('..', '..', 'database'), __FILE__)

module UserWorker
  def perform(user_id)
    @user = User.find(user_id)
    if @user
      begin
        @user.login()
        @user.popular().each do |m|
          m.like() unless m.image_info['has_liked']
          m.comment("Hi there")
          m.follow_author
        end
      rescue => e
        @user.increment!(:errors_count)
        error_message = "#{e.message}\n==>\n#{e.backtrace}"
        @user.update_attribute(:last_error, error_message)
      ensure
        Resque.enqueue(self, user_id) if @user.active
      end

    end
  end
end
