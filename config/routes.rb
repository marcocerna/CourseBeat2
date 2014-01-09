CourseBeat::Application.routes.draw do
  root to: "lessons#index"
  post "/lessons/vote", to: "lessons#vote"
  resources :lessons
end
