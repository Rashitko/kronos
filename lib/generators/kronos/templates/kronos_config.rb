require 'kronos'
Kronos.configure do |config|
  # Add paths which should be ommited
  # config.exclude_path('/path/which/should/not/be/logged/*')

  # Params which won't be logged in the kronos_request.request_params
  config.excluded_params = ['action', 'controller', 'format']
end