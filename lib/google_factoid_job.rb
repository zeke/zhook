class GoogleFactoidJob < Struct.new(:organization_id)
  
  def perform
    crawler = GoogleCrawler.new
    crawler.find_organization(organization_id)
  end
  
end