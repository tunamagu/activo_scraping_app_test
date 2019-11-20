class JobOffer < ApplicationRecord
  validates :title, presence: true
  validates :owner_name, presence: true
  validates :url, presence: true

  def link_job_offer_list_with_owner(new_job_offer_list)
    for new_job_offer in new_job_offer_list do
      check_for_relationship(new_job_offer)
    end
  end

  # 新規の求人をDBに格納する
  # todo 保存に失敗した場合の処理がかけてない
  def save_job_offer_list(new_job_offer_list)
    for new_job_offer in new_job_offer_list do
      unless new_job_offer.save
        logger.error("")
      end
    end
  end

  # 渡された求人情報から登録されていない新規の求人を返す
  def select_new_job_offer_list(all_job_offer_list)
    new_job_offer_list = all_job_offer_list.select do |job_offer|
      !JobOffer.exists?(url: job_offer.url)
    end
    return new_job_offer_list
  end

  private

    def check_for_relationship(new_job_offer)
      if Owner.find_by(name: new_job_offer.owner_name)
        create_relationship(new_job_offer)
      end
    end

    def create_relationship(new_job_offer)
      owner = Owner.find_by(name: new_job_offer.owner_name)
      Relationship.create(job_offer_id: new_job_offer.id , owner_id: owner.id)
    end
end
