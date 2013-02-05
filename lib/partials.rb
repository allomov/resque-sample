module Sinatra
  module Partials
    def partial(template, options = {})
      options.merge!(:layout => false)
      # raise options.inspect
      if collection = options.delete(:collection)
        collection.inject([]) do |buffer, member|
          buffer << erb(template, options.merge(layout: false, :locals => {template.to_sym => member}))
        end.join("\n")
      else
        erb(template, options)
      end
    end
  end
end

helpers Sinatra::Partials