Rails.application.routes.draw do
  root 'transactions#index'

  get  'imports'              => 'imports#index',    as: 'import'
  post 'upload'               => 'imports#upload',   as: 'upload'
  get  'imports/download/:id' => 'imports#download', as: 'import_download'
end
