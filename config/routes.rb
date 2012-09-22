Refinery::Core::Engine.routes.draw do

  match ":path/page/:page" => "pages#show", :as => :page
  match ":path" => "pages#show", :as => :page , :page => 1

  namespace "photo_gallery", :path => '' do
    namespace :admin, :path => 'refinery' do
      scope :path => 'photo-gallery' do
        root :to => "albums#index"

        resources :photos do
          collection do
            put :update_multiple
          end
        end

        resources :albums do
          resources :photos do
            collection do
              get :upload
              get :edit_multiple
            end
          end
        end

        resources :collections

      end
    end
  end
end
