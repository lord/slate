require 'nokogiri'

def toc_data(page_content)
  html_doc = Nokogiri::HTML::DocumentFragment.parse(page_content)

  # get a flat list of headers
  headers = []
  html_doc.css('h1, h2, h3').each do |header|
    headers.push({
      id: header.attribute('id').to_s,
      content: header.content,
      level: header.name[1].to_i,
      children: []
    })
  end

  puts headers.inspect
  [3,2].each do |header_level|
    header_to_nest = nil
    headers = headers.reject do |header|
      if header[:level] == header_level
        header_to_nest[:children].push header if header_to_nest
        true
      else
        header_to_nest = header if header[:level] == (header_level - 1)
        false
      end
    end
  end
  headers
end