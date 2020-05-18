# class CarsSpider < Kimurai::Base
#   @name = 'cars_spider'
#   @engine = :mechanize

#   def self.process(url)
#     @start_urls = [url]
#     self.crawl!
#   end

#   def parse(response, url:, data: {})
#     debugger
#     if response.present?
#       response.css('.cldt-summary-titles').each do |pp|
#         item = {}
#         debugger
#         item[:title] = pp.css('h2[1]').text + "" +  pp.css('h2[2]').text
#         Car.where(item).first_or_create
#       end
#     end
#   end

#   def parse(response1, url:, data: {})
#     if response1.present?
#       response1.css('div.sc-grid-row').css('div.sc-pull-right').css('dt').children.each do |chil|
#         debugger
#         item = {}
#         item[:title] = response1.css('div.sc-grid-row').css('div.sc-pull-right').css('h3').children.text
#         item[:sub_title] = chil.text
#         item[:title] = response1.css('div.cldt-collapsable').children[4].children.text
#         # detail
#         item[:sub_title] = response1.css('div.sc-grid-row').css('div.sc-pull-left').children[1].children.text
#         # state
#         item[:stock_type] =response1.css('div.sc-grid-row').css('div.sc-pull-left').children[3].children[1].children.text
#         # type
#         response1.css('div.sc-grid-row').css('div.sc-pull-left').children[3].children[3].children.children.text
#         # new
#         item[:stock_type] =response1.css('div.sc-grid-row').css('div.sc-pull-left').css('dt').children[1].text
#         # "Non-smoking Vehicle"
#         item[:sub_title] = response1.css('div.sc-grid-row').css('div.sc-pull-left').children[6].children.text
#         # drive
#         item[:stock_type] =response1.css('div.sc-grid-row').css('div.sc-pull-left').css('dt').children[2].text
#         # "Gearing Type"

#         item[:stock_type] =response1.css('div.sc-grid-row').css('div.sc-pull-left').css('dt').children[3].text
#     # weight
#         b = response1.css('div.sc-grid-row').css('div.sc-pull-right')
#         b.css('dd').children.each_with_index do |val, index|
#           item[:stock_type] << val.text.strip if index.even?
#         end
#         item[:stock_type].insert(7, b.css('dd').children[14].text.strip)

#         CarsSpider.where(item).first_or_create
#       end
  
        
#     end

#   end
# end
