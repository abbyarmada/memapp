Rails.application.routes.draw do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
# Serve websocket cable requests in-process
# mount ActionCable.server => '/cable'
  resources :members do
		collection do
		  get 'carpark_passes'
		end
 	end

  resources :privileges

  devise_for :users
  resources :boats do
    collection do
    get 'create_csv'
    end
  end

  resources :paymenttypes

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
	resources :payments do
		collection  do
			get 'listytd'
			get 'list_by_member_class'
			get 'tot_by_member_class'
      get 'tot_by_member_class_2'
			get 'receipts_breakdown'
			get 'overduememberships'
			get 'overduememberships2'
			get 'drill_pay'
			get 'g_chart_mems'
			get 'auto_renew_life_honorary'
		end
	end

	resources :people do
	  collection do
	    get 'bar_interface'
	    get 'paid_up_extract'
	    get 'paid_up_extract_current'
	    get 'paid_up_extract_last_year'
	    get 'paid_up_extract_two_year_ago'
	    get 'paid_up_extract_three_year_ago'
      get 'paid_up_extract_four_year_ago'
      get 'paid_up_extract_five_year_ago'
	    get 'comms_csv'
	    get 'create_renewals'
	    get 'renewal_email'
      get 'cut'
      post 'newmember'
      post 'paste'
	  end
	end


	resources :subscriptions
	resources :privileges
	resources :barcards
	resources :peoplebarcards
	resources :renewals do
     post :generate_pdfs, :on => :member
     post :generate_emails, :on => :member
    # post 'renewals_email'
	  collection do
	   get :download_zip
	  end


	end

  authenticated :user do
    root :to => 'people#index', :as => :authenticated_root
  end
  root :to => redirect('/users/sign_in')

end
