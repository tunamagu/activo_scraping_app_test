class MoshicomScraping < BaseScraping

  def initialize
    @url = 'https://moshicom.com/search/?keywords=&date_start=&date_end=&disciplines%5B8%5D=11&scale=0&sort=2&disp_limit=20&mode=1'
    @article_xpath = '//*[@class="card card-eventSingle "]'
    @title_xpath = '//*[@class="two-four-lines text-jadegreen"]'
    @owner_xpath ='//*[@class="d-inline-block text-truncate"]'
  end

  def scraping_job_offer_list
    all_job_offer_list = job_offer_page_old = []

    1.step do |i|
      url_page = "#{@url}&page=#{i}"

      job_offer_page = fetch_job_offer_list_from_url(url_page)
      all_job_offer_list += job_offer_page

      if select_job_offer_list_first_url(job_offer_page) == select_job_offer_list_first_url(job_offer_page_old)
        break
      end
      job_offer_page_old = job_offer_page

    end
    return all_job_offer_list
  end

  private

    def select_job_offer_from_article(article)
      article_html = Nokogiri::HTML(article.to_s)
      job_offer = JobOffer.new
      job_offer.title = article_html.xpath(@title_xpath).children.text
      job_offer.owner_name = article_html.xpath(@owner_xpath).children.text
      job_offer.url = "https://moshicom.com#{article_html.xpath(@title_xpath).attribute('href').value}"
      return job_offer
    end
end
