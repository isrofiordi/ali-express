nokogiri = Nokogiri.HTML(content)

# Cek apakah tidak ada item di sini
is_page_not_available = nokogiri.at_css("div.query-help-wrap > p > i")

unless is_page_not_available
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
end


# load next page
indeks = page['vars']['i']
indeks += 1 #page selanjutnya
next_url = page['vars']['root-url']+"?page=#{indeks}" #Next Url


# input ke pages queue
unless is_page_not_available
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