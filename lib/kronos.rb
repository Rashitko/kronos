require 'kronos/version'
require 'kronos/configuration'

require 'counter_culture'

require 'app/models/kronos_fragment'
require 'app/models/kronos_request'
require 'app/models/kronos_log_entry'

require 'active_admin'

module Kronos
  def kronos_log
    start = Time.now.to_f
    @log_entries = []
    @kronos_request = KronosRequest.new
    exception = nil
    begin
      yield
    rescue => ex
      exception = ex
    end
    unless Kronos.configuration.is_excluded?(request.path)
      fragment_hash = {}
      fragment_hash[:request_path] = request.path
      fragment = KronosFragment.find_or_create_by(fragment_hash)

      request_hash = {}
      request_hash[:request_params] = params.except(*Kronos.configuration.excluded_params).to_json
      request_hash[:request_method] = request.method
      request_hash[:remote_ip] = request.remote_ip
      request_hash[:duration] = ((Time.now.to_f - start) * 1000).ceil
      request_hash[:kronos_fragment_id] = fragment.id
      request_hash[:controller] = params[:controller]
      request_hash[:action] = params[:action]
      @kronos_request.update_attributes(request_hash)
      puts "saving logs"
      @log_entries.map(&:save!)
      @kronos_request.save!
    end
    if exception
      raise exception
    end
  end

  def kronos_log_debug(message)
    @log_entries << KronosLogEntry.new(level: KronosLogEntry::LEVEL_DEBUG, message: message, kronos_request: @kronos_request)
  end

  def kronos_log_info(message)
    @log_entries << KronosLogEntry.new(level: KronosLogEntry::LEVEL_INFO, message: message, kronos_request: @kronos_request)
  end

  def kronos_log_warning(message)
    @log_entries << KronosLogEntry.new(level: KronosLogEntry::LEVEL_WARNING, message: message, kronos_request: @kronos_request)
  end

  def kronos_log_error(message)
    @log_entries << KronosLogEntry.new(level: KronosLogEntry::LEVEL_ERROR, message: message, kronos_request: @kronos_request)
  end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

end
