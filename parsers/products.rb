nokogiri = Nokogiri.HTML(content)

# initialize an empty hash
product = {}

#save the url
product['url'] = page['vars']['url']

#save the category
product['category'] = page['vars']['category']

#extract title
product['title'] = nokogiri.at_css('.product-title-text').text.strip unless nokogiri.at_css('.product-title-text').nil?

#extract product image
product['image_url'] = nokogiri.at_css('img.magnifier-image')['src'] unless nokogiri.at_css('img.magnifier-image')['src'].nil?

#extract discount price
product['discount_price'] = nokogiri.at_css('.product-price-current > span:nth-child(1)').text.strip unless nokogiri.at_css('.product-price-current > span:nth-child(1)').nil?

#extract original price
product['original_price'] = nokogiri.at_css('.product-price-del > span:nth-child(1)').text.strip unless nokogiri.at_css('.product-price-del > span:nth-child(1)').nil?

#extract sizes
sizes_element = nokogiri.css('div.sku-property:nth-child(2) > ul:nth-child(2) li')
product['sizes'] = []
if sizes_element
    sizes_element.each do |size|
        product['sizes'] << size.text.strip
    end
end

#extract rating and reviews
product['rating'] = nokogiri.at_css('#root > div > div.product-main > div > div.product-info > div.product-reviewer > div > span').text.strip unless nokogiri.at_css('#root > div > div.product-main > div > div.product-info > div.product-reviewer > div > span').nil?
product['reviews_count'] = nokogiri.at_css('#root > div > div.product-main > div > div.product-info > div.product-reviewer > span.product-reviewer-reviews.black-link').text.strip unless nokogiri.at_css('#root > div > div.product-main > div > div.product-info > div.product-reviewer > span.product-reviewer-reviews.black-link').nil?

#extract orders count
product['orders_count'] = nokogiri.at_css('#root > div > div.product-main > div > div.product-info > div.product-reviewer > span.product-reviewer-sold').text.strip unless nokogiri.at_css('#root > div > div.product-main > div > div.product-info > div.product-reviewer > span.product-reviewer-sold').nil? 

#extract shipping info
product['shipping_info'] = nokogiri.at_css('#root > div > div.product-main > div > div.product-info > div.product-shipping > span.product-shipping-info.black-link').text.strip unless nokogiri.at_css('#root > div > div.product-main > div > div.product-info > div.product-shipping > span.product-shipping-info.black-link').nil?

#extract return policy
product['return_policy'] = nokogiri.at_css('#root > div > div.product-main > div > div.product-info > div.buyer-pretection > div > a:nth-child(2) > div.buyer-pretection-content > div.buyer-pretection-title.bold').text.strip unless nokogiri.at_css('#root > div > div.product-main > div > div.product-info > div.buyer-pretection > div > a:nth-child(2) > div.buyer-pretection-content > div.buyer-pretection-title.bold').nil?
product['return_policy'] = product['return_policy'] + ": " + nokogiri.at_css('#root > div > div.product-main > div > div.product-info > div.buyer-pretection > div > a:nth-child(2) > div.buyer-pretection-content > div.buyer-pretection-context').text.strip unless nokogiri.at_css('#root > div > div.product-main > div > div.product-info > div.buyer-pretection > div > a:nth-child(2) > div.buyer-pretection-content > div.buyer-pretection-context').nil?

#extract guarantee
product['guarantee'] = nokogiri.at_css('#root > div > div.product-main > div > div.product-info > div.buyer-pretection > div > a:nth-child(1) > div.buyer-pretection-content > div.buyer-pretection-title.bold').text.strip unless nokogiri.at_css('#root > div > div.product-main > div > div.product-info > div.buyer-pretection > div > a:nth-child(1) > div.buyer-pretection-content > div.buyer-pretection-title.bold').nil?
product['guarantee'] = product['guarantee'] + ": " + nokogiri.at_css('#root > div > div.product-main > div > div.product-info > div.buyer-pretection > div > a:nth-child(1) > div.buyer-pretection-content > div.buyer-pretection-context').text.strip unless nokogiri.at_css('#root > div > div.product-main > div > div.product-info > div.buyer-pretection > div > a:nth-child(1) > div.buyer-pretection-content > div.buyer-pretection-context').nil?

# specify the collection where this record will be stored
product['_collection'] = "products"

# save the product to the job’s outputs
outputs << product