module Kronos
  class KronosFragment < ActiveRecord::Base

    has_many :kronos_requests, dependent: :destroy
    belongs_to :longest_request, class_name: 'KronosRequest'

  end
end