Rails.application.routes.draw do
  resource :locations, only: [] do
    collection do
      post :distance
    end
  end
  resource :cost, only: [:show]
end
