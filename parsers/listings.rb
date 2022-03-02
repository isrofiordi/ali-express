nokogiri = Nokogiri.HTML(content)

#load products
products = nokogiri.css('.JIIxO a._3t7zg')
products.each do |product|
  url = "https://www.aliexpress.com" + product['href'].text
  # puts "ahaide"
  url = url.split('?').first
  pages <<{
    url: url,
    page_type: 'products',
    fetch_type: 'browser',
    force_fetch: true,
    vars: {
      category: page['vars']['category'],
      url: url
    }
  }
  outputs << {url:url}
end

# products.each do |product|
#   a_element = product
#   if a_element
#     url = URI.join('https:', a_element['href']).to_s.split('?').first
#     if url =~ /\Ahttps?:\/\//
#       pages << {
#           url: url,
#           page_type: 'products',
#           fetch_type: 'browser',
#           force_fetch: true,
#           vars: {
#             category: page['vars']['category'],
#             url: url
#           }
#         }
#     end
#   end
# end

#load paginated links
pagination_links = nokogiri.css('#pagination-bottom a')
pagination_links.each do |link|
  l_val = link.text.strip
  if l_val !~ /next|previous/i && l_val.to_i < 11 #limit pagination to 10 pages
    url = URI.join('https:', link['href']).to_s.split('?').first
    pages << {
        url: url,
        page_type: 'listings'
      }
  end
end