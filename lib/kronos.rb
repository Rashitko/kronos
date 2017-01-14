require 'kronos/version'

module Kronos
  def kronos_log
    start = Time.now.to_f
    yield
    hash = {}
    hash[:duration] = ((Time.now.to_f - start) * 1000).ceil
    puts "Duration #{hash[:duration]}"
    hash[:params] = params.except('action', 'controller').to_json
    hash[:request_method] = 'GET'
    hash[:source_ip] = 'localhost'
    KronosFragment.create(hash)
  end
end
