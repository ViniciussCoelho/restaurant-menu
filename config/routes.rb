Rails.application.routes.draw do
  resources :menu_items

  resources :restaurants do
    resources :menus, controller: 'restaurants/menus'
  end

  resources :menus do
    resources :menu_listings, controller: 'menus/menu_listings'
  end

  post 'import_json_data', to: 'imports#upload'
end
