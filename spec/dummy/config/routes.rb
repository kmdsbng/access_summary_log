Rails.application.routes.draw do

  match 'sample/sample_action' => 'sample#sample_action', :via => :get

  mount AccessSummaryLog::Engine => "/access_summary_log"
end
