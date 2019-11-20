namespace :scraping_job_offers do
  desc "Scraping job information from website"
  task scraping_job_offers: :environment do

    require 'open-uri'
    require 'nokogiri'

    job_offer = JobOffer.new
    job_offer_list = []

    moshicom = MoshicomScraping.new
    job_offer_list += moshicom.scraping_job_offer_list
    blueship = BlueshipScraping.new
    job_offer_list += blueship.scraping_job_offer_list

    new_job_offer_list = job_offer.select_new_job_offer_list(job_offer_list)

    job_offer.save_job_offer_list(new_job_offer_list)

    job_offer.link_job_offer_list_with_owner(new_job_offer_list)
  end

end
