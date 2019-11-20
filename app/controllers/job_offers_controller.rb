class JobOffersController < ApplicationController
  def index_from_scraping
    relationships = Relationship.all
    @job_offers = []
    for relationship in relationships do
      @job_offers << JobOffer.find(relationship.job_offer_id)
    end
  end
end
