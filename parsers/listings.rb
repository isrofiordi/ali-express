nokogiri = Nokogiri.HTML(content)

#load products
products = nokogiri.css('.JIIxO a._3t7zg')
products.each do |product|
  url = "https://www.aliexpress.com" + product['href']
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

# load next page
indeks = page['vars']['i']
puts indeks
next_url = page['vars']['root-url']+"?page=#{indeks}" if indeks < 11
indeks += 1 #page selanjutnya

# input ke pages
if indeks < 11
  pages << {
    page_type: "listings",
    method: "GET",
    headers: {"User-Agent" => "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"},
    url: next_url,
    vars: {
      category: "Women's clothing",
      "root-url" => "https://www.aliexpress.com/category/100003109/women-clothing.html",
      "i" => indeks
    },
    fetch_type: "browser",
    driver: {
      code: "
        await page.evaluate('window.scrollBy(0,1200)');
        await sleep(1000);
        await page.evaluate('window.scrollBy(0,1200)');
        await sleep(1000);
        await page.evaluate('window.scrollBy(0,1200)');
        await sleep(1000);
        await page.evaluate('window.scrollBy(0,1200)');
        await sleep(1000);
        await page.evaluate('window.scrollBy(0,1200)');
        await sleep(1000);
      "
    }
  }
end


# pagination_links = nokogiri.css('#pagination-bottom a')
# pagination_links.each do |link|
#   l_val = link.text.strip
#   if l_val !~ /next|previous/i && l_val.to_i < 11 #limit pagination to 10 pages
#     url = URI.join('https:', link['href']).to_s.split('?').first
#     pages << {
#         url: url,
#         page_type: 'listings'
#       }
#   end
# end