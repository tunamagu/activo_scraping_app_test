class BlueshipScraping < BaseScraping

  def initialize
    @url = 'https://blueshipjapan.com/search/event/catalog?area=0&text_date=&date=1&text_keyword=&cancelled=0&cancelled=1&order=desc'
    @article_xpath = '//li[@class="event_item gallery_item"]'
    @title_xpath = '//*[@id="main_content"]/h1'
    @url_xpath = '//*[@class="event_title"]/a'
    @owner_xpath ='//*[@class="body_container"]/div[@class="right"]/table//tr/td/a/span'
  end


  def scraping_job_offer_list
    all_job_offer_list = job_offer_page_old = []

    0.step do |i|
      url_page = "#{@url}&per_page=#{i*18}"

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

    def select_job_offer_from_article(article_html)
      article_html = Nokogiri::HTML(article_html.to_s)
      job_offer = JobOffer.new
      job_offer.url = article_html.xpath(@url_xpath).attribute('href').value
      job_offer.title = fetch_title_from_article_page(job_offer.url)
      job_offer.owner_name = fetch_owner_from_article_page(job_offer.url)
      return job_offer
    end

    def fetch_title_from_article_page(url)
       html = fetch_html_from_url(url)
       html.xpath(@title_xpath).children.text
    end

    def fetch_owner_from_article_page(url)
       html = fetch_html_from_url(url)
       html.xpath(@owner_xpath).children.text
    end

end
