class Tag < ActiveRecord::Base
  attr_accessible :count, :name

  scope :check_availability, lambda { |name| where("name = ?", name)}

  has_many :products, dependent: :destroy

  validates :name, presence: true

  after_save    :expire_contact_all_cache

  after_destroy :expire_contact_all_cache

  def self.all_cached(tag)
    Rails.cache.fetch("cache-#{tag.name}") do
      tag.products
    end
  end


  def self.update_products
    Tag.all.each do |tag|
      tag.products.destroy_all
      Tag.fetch_amazon_data(tag)
    end
  end

  def expire_contact_all_cache
    Rails.cache.delete("cache-#{self.name}")
  end

  def self.fetch_amazon_data(tag)
    hydra = Typhoeus::Hydra.new
    fibers = [Fiber.current]
    data = []
    num_of_product = tag.products.count
    service_url = "http://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&field-keywords=#{CGI::escape(tag.name)}&page="

    request1 = Typhoeus::Request.new(service_url+"1")
    request1.on_complete { |response| data << do_process(response) }

    request2 = Typhoeus::Request.new(service_url+"2")
    request2.on_complete { |response| data << do_process(response) }

    fibers << Fiber.new do
      hydra.queue(request1)
      hydra.queue(request2)
      hydra.run
    end

    fibers.last.resume

    hydra = Typhoeus::Hydra.new
    products = []

    data.flatten.each do |datum|
      fibers << Fiber.new do
        request = Typhoeus::Request.new(datum[:url])

        request.on_complete do |response|
          html2 = Nokogiri::HTML(response.body)
          desc = CGI::escape(html2.css('div#productDescription div.content div.productDescriptionWrapper').text).encode rescue "-"
          price = html2.css('span#actualPriceValue b.priceLarge').text rescue nil
          rate = html2.css('span.tiny span.crAvgStars span.asinReviewsSummary a span.swSprite').to_s rescue "-"
          you_save = html2.css('span#youSaveValue').text rescue "-"
          price_msg = html2.css('#actualPriceExtraMessaging').text rescue "-"

          products << {
            asin: datum[:asin],
            name: datum[:name],
            desc: desc,
            image_url: datum[:image_url],
            rate: rate,
            buy_price: price,
            tag_id: tag.id,
            url: datum[:url],
            listprice: datum[:listprice],
            you_save: you_save,
            price_msg: price_msg
          }
        end

        hydra.queue(request)
      end

      fibers.last.resume
    end

    hydra.run

    product_asin_ids = tag.products.pluck(:asin)

    products.delete_if do |product|
      if product_asin_ids.include?(product[:asin])
        true
      else
        product_asin_ids << product[:asin]
        false
      end
    end

    Product.create(products)
  end

  private

    def self.do_process(response)
      html = Nokogiri::HTML(response.body)
    results = html.css(".list.results div")
    rv = []
    counter = 1
    results.each do |result|
      fiber = Fiber.new do
        image_url = result.css("div.image a img.productImage").first.attributes["src"].value rescue nil
        url = result.css("div.image a").first.attributes["href"].value rescue nil
        name = result.css(".newaps a").text.encode rescue "-"
        listprice = result.css("ul.rsltL li a del").text rescue "-"
        asin = result.attributes["name"].value rescue nil

        if url and image_url and asin
          rv << { url: url, image_url: image_url, name: name, listprice: listprice, asin: asin }
        end
      end

      fiber.resume
    end

    return rv
    end

  end

