Rails.application.routes.draw do
  root 'dashboard#index'

  get  'dashboard'            => 'dashboard#index',    as: 'dashboard'
  get  'imports'              => 'imports#index',      as: 'import'
  post 'upload'               => 'imports#upload',     as: 'upload'
  get  'imports/download/:id' => 'imports#download',   as: 'import_download'
  get  'imports/message/:id'  => 'imports#message',    as: 'import_message'

  get  'transactions'         => 'transactions#index', as: 'transactions'
end
