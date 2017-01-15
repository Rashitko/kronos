require 'kronos/version'
require 'kronos/configuration'

module Kronos
  class Configuration
    attr_accessor :excluded_paths, :excluded_params

    def initialize
      @excluded_paths = []
      @excluded_params = []
    end

    def exclude_path(path)
      @excluded_paths << Regexp.new(path)
    end

    def is_excluded?(path)
      @excluded_paths.each do |regex|
        if path.match(regex)
          puts "Path #{path} is excluded from Kronos based on #{regex} regex."
          return true
        end
      end
      false
    end
  end
end