# == Route Map
#
#                                Prefix Verb   URI Pattern                                                                              Controller#Action
#                       api_v1_otp_send POST   /api/v1/otp/send(.:format)                                                               api/v1/otp_authentication#send_otp
#                     api_v1_otp_verify POST   /api/v1/otp/verify(.:format)                                                             api/v1/otp_authentication#verify_otp_and_login
#              api_v1_user_connect_mode GET    /api/v1/user/connect_mode(.:format)                                                      api/v1/user_celebs#connect_mode
#                     api_v1_party_mode GET    /api/v1/party_mode(.:format)                                                             api/v1/croosh#party_mode
#                                api_v1 POST   /api/v1/croosh/:croosh_id/toggle_user_like(.:format)                                     api/v1/croosh#toggle_user_like
#                                       POST   /api/v1/croosh/:croosh_id/toggle_celeb_like(.:format)                                    api/v1/croosh#toggle_celeb_like
#                                       POST   /api/v1/croosh/:croosh_id/increment_share(.:format)                                      api/v1/croosh#increment_share
#                   api_v1_user_profile GET    /api/v1/user/profile(.:format)                                                           api/v1/users#profile
#        api_v1_user_change_profile_pic POST   /api/v1/user/change_profile_pic(.:format)                                                api/v1/users#change_profile_pic
#               api_v1_user_change_name POST   /api/v1/user/change_name(.:format)                                                       api/v1/users#change_name
#                                       GET    /api/v1/celeb/:celeb_id/profile(.:format)                                                api/v1/user_celebs#celeb_profile
#          api_v1_user_profile_pic_show GET    /api/v1/user_profile_pic/show(.:format)                                                  api/v1/user_profile_pic#show
#          api_v1_create_croosh_request POST   /api/v1/create_croosh_request(.:format)                                                  api/v1/croosh#create_croosh_request
#             api_v1_croosh_order_token POST   /api/v1/croosh/order_token(.:format)                                                     api/v1/croosh#order_token
#           api_v1_celeb_session_create POST   /api/v1/celeb_session/create(.:format)                                                   api/v1/celeb_session#create
#            api_v1_celeb_connect_index GET    /api/v1/celeb_connect/index(.:format)                                                    api/v1/celeb_connect#index
#             api_v1_celeb_connect_show GET    /api/v1/celeb_connect/show(.:format)                                                     api/v1/celeb_connect#show
#         api_v1_celeb_profile_pic_show GET    /api/v1/celeb_profile_pic/show(.:format)                                                 api/v1/celeb_profile_pic#show
#                         api_v1_croosh POST   /api/v1/croosh(.:format)                                                                 api/v1/croosh#create
#         rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#create
#         rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                  action_mailbox/ingresses/postmark/inbound_emails#create
#            rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                     action_mailbox/ingresses/relay/inbound_emails#create
#         rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                  action_mailbox/ingresses/sendgrid/inbound_emails#create
#          rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                              action_mailbox/ingresses/mailgun/inbound_emails#create
#        rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#index
#                                       POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#create
#         rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#show
#                                       PATCH  /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       PUT    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       DELETE /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#destroy
# rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                      rails/conductor/action_mailbox/reroutes#create
#                    rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#             rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                    rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#             update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#                  rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

#         rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#create
#         rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                  action_mailbox/ingresses/postmark/inbound_emails#create
#            rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                     action_mailbox/ingresses/relay/inbound_emails#create
#         rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                  action_mailbox/ingresses/sendgrid/inbound_emails#create
#          rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                              action_mailbox/ingresses/mailgun/inbound_emails#create
#        rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#index
#                                       POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#create
#         rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#show
#                                       PATCH  /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       PUT    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       DELETE /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#destroy
# rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                      rails/conductor/action_mailbox/reroutes#create
#                    rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#             rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                    rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#             update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#                  rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create


Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      post 'otp/send', to: 'otp_authentication#send_otp'
      post 'otp/verify', to: 'otp_authentication#verify_otp_and_login'

      get 'user/connect_mode', to: 'user_celebs#connect_mode'
      get 'party_mode', to: 'croosh#party_mode'

      post 'croosh/:croosh_id/toggle_user_like', to: 'croosh#toggle_user_like'
      post 'croosh/:croosh_id/toggle_celeb_like', to: 'croosh#toggle_celeb_like'
      post 'croosh/:croosh_id/increment_share', to: 'croosh#increment_share'

      get 'user/profile', to: 'users#profile'
      post 'user/change_profile_pic', to: 'users#change_profile_pic'
      post 'user/change_name', to: 'users#change_name'

      get 'celeb/:celeb_id/profile', to: 'user_celebs#celeb_profile'

      get 'user_profile_pic/show'

      post 'create_croosh_request', to: 'croosh#create_croosh_request'

      post 'croosh/order_token'


      # Celeb
      post 'celeb_session/create', to: 'celeb_session#create'

      get 'celeb_connect/index'
      get 'celeb_connect/show'

      get 'celeb_profile_pic/show'

      post 'croosh', to: 'croosh#create'

    end
  end
end
