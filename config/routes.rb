Rails.application.routes.draw do
    scope '/api' do

    resources :tags do
      collection do 
        get ":entity_type/:entity_id" => "tags#get_entity_tags"
        delete ":entity_type/:entity_id" => "tags#delete_entity_tag"
        get "statistics" => "tags#tag_statistics"
        get "statistics/:entity_type/:entity_id" => "tags#entity_wise_statistics"
      end
    end

    
end
end
