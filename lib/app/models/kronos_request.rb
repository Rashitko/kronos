module Kronos
  class KronosRequest < ActiveRecord::Base

    belongs_to :kronos_fragment
    has_many :kronos_log_entries, dependent: :destroy

    counter_culture :kronos_fragment, column_name: 'kronos_requests_count'

    serialize :request_params, JSON

    after_save :update_max
    after_destroy :set_max_from_others

    private
    def update_max
      if not kronos_fragment.longest_request or kronos_fragment.longest_duration < duration
        kronos_fragment.longest_request = self
        kronos_fragment.longest_duration = self.duration
      end
      set_average_duration
      kronos_fragment.save!
    end

    def set_average_duration
      durations = kronos_fragment.kronos_requests.order('created_at DESC').limit(30).map(&:duration)
      unless durations.empty?
        kronos_fragment.average_duration = durations.reduce(:+) / durations.size.to_f
      end
    end

    def set_max_from_others
      longest = kronos_fragment.kronos_requests.order('duration DESC').limit(1).first
      kronos_fragment.longest_request = longest
      if longest
        kronos_fragment.longest_duration = longest.duration
      else
        kronos_fragment.longest_duration = nil
      end
      if kronos_fragment.kronos_requests.empty?
        kronos_fragment.average_duration = nil
      else
        set_average_duration
      end
      kronos_fragment.save!
    end

  end
end