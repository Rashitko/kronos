module Kronos
  class KronosLogEntry < ActiveRecord::Base

    belongs_to :kronos_request

    LEVEL_DEBUG = 0
    LEVEL_INFO = 1
    LEVEL_WARNING = 2
    LEVEL_ERROR = 3

  end
end