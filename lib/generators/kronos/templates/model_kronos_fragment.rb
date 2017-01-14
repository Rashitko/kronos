class KronosFragment < ActiveRecord::Base

  serialize :request_params, JSON

end
