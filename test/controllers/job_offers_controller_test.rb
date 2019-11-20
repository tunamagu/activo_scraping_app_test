require 'test_helper'

class JobOffersControllerTest < ActionDispatch::IntegrationTest
  test "should get index_from_scraping" do
    get job_offers_index_from_scraping_url
    assert_response :success
  end

end
