class SiteFactoidJob < Struct.new(:organization_id)

  def perform
    crawler = SiteCrawler.new
    crawler.crawl_organization(organization_id)
  end

end