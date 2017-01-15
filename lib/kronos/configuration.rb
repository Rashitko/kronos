require 'kronos/version'
require 'kronos/configuration'

module Kronos
  class Configuration
    attr_accessor :excluded_paths

    def initialize
      @excluded_paths = []
    end

    def exclude_path(path)
      @excluded_paths << Regexp.new(path)
    end

    def is_excluded?(path)
      @excluded_paths.each do |regex|
        return true if path.match(regex)
      end
      false
    end
  end
end