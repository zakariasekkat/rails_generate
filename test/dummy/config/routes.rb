Rails.application.routes.draw do
  mount RailsGenerate::Engine => "/rails_generate"
end
