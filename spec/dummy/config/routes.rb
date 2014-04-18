Rails.application.routes.draw do

  mount AccessSummaryLog::Engine => "/access_summary_log"
end
