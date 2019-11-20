require 'rails_helper'

RSpec.describe JobOffer, type: :model do

  # 求人の保存テスト
  it "link_job_offer_list_with_owner_test" do
    job_offer_1 = JobOffer.create(title: "joboffer1",owner_name: "jobowner1",url: "https://example1.com")
    job_offer_2 = JobOffer.create(title: "joboffer2",owner_name: "jobowner2",url: "https://example2.com")
    job_offer_list = [
      job_offer_1,
      job_offer_2
    ]
    job_offer_1.link_job_offer_list_with_owner(job_offer_list)
    expect(JobOffer.all).to eq job_offer_list
  end

  # リレーション作成をテスト
  it "link_job_offer_with_owner_test" do
    job_offer = JobOffer.create(title: "title3",owner_name: "owner3",url: "https://url.com/3/")
    new_job_offer_list = [
      job_offer
    ]
    Owner.create(name: "owner3")

    job_offer.link_job_offer_list_with_owner(new_job_offer_list)
    expect(Relationship.exists?(job_offer.id)).to eq true
  end

  # 新規選別テスト
  it "select_new_job_offer_list_test" do
    preserved_job_offer = JobOffer.create(title: "title1",owner_name: "owner1",url: "https://url.com/1/")
    new_job_offer = JobOffer.new(title: "title2",owner_name: "owner2",url: "https://url.com/2/")
    new_job_offer_list = [
      preserved_job_offer,
      new_job_offer
    ]

    expect_job_offer_list = [new_job_offer]
    expect(new_job_offer.select_new_job_offer_list(new_job_offer_list)).to eq expect_job_offer_list
  end

end
