set :environment, "development"
set :output, { :error => "log/cron_error.log" }
set :path, "/home/tuna/rails/scraping_app"

every 1.day, :at => '7:00' do
  rake scraping_job_offers:scraping_job_offers
end
