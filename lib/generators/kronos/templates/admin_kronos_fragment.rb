ActiveAdmin.register KronosFragment do
  actions :all, except: [:destroy, :new, :update]

  config.sort_order = 'created_at_desc'

end