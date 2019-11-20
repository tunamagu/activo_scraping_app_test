class BaseScraping

  private


    def fetch_html_from_url(url)
      charset = nil
      html = open(url) do |f|
        charset = f.charset
        f.read
      end

      doc = Nokogiri::HTML.parse(html, nil, charset)
    end

    def select_job_offer_list_first_url(job_offer_list)
      if job_offer_list[0]
        job_offer_list[0].url
      end
    end

    def fetch_job_offer_list_from_url(url)
      html = fetch_html_from_url(url)
      take_out_job_offer_list_from_html(html)
    end

    def take_out_job_offer_list_from_html(html)
      job_offers_list = []
      html.xpath(@article_xpath).each do |article|
        job_offers_list << select_job_offer_from_article(article)
      end
      return job_offers_list
    end

    def select_job_offer_from_article(article_html)
      article_html = Nokogiri::HTML(article_html.to_s)
      job_offer = JobOffer.new
      job_offer.title = article_html.xpath(@title_xpath).children.text
      job_offer.owner_name = article_html.xpath(@owner_xpath).children.text
      job_offer.url = article_html.xpath(@title_xpath).attribute('href').value
      return job_offer
    end

end
