Rails.application.routes.draw do
  root 'dashboard#index'

  get  'api/dashboard/graph'         => 'api/dashboard#graph',        as: 'api_dashboard_graph',        defaults: { format: 'json' }
  get  'api/transactions/categories' => 'api/transaction#categories', as: 'api_transaction_categories', defaults: { format: 'json' }
  get  'dashboard'                   => 'dashboard#index',            as: 'dashboard'
  get  'dashboard/:account'          => 'dashboard#index',            as: 'dashboard_account'
  get  'imports'                     => 'imports#index',              as: 'import'
  post 'upload'                      => 'imports#upload',             as: 'upload'
  get  'imports/download/:id'        => 'imports#download',           as: 'import_download'
  get  'imports/message/:id'         => 'imports#message',            as: 'import_message'
  get  'transactions'                => 'transactions#index',         as: 'transactions'
  get  'select-account/:account'     => 'accounts#select',            as: 'select_account'
  get  'settings'                    => 'settings#edit',              as: 'edit_settings'
  put  'settings/:id'                => 'settings#update',            as: 'update_settings'
  get  'settings/cancel'             => 'settings#cancel',            as: 'cancel_settings'
  get  'search'                      => 'transactions#index',         as: 'search'
end
