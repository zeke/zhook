module OrganizationsHelper
  
  def path_for_format(format="xml")
    p = params
    p.delete("action")
    p.delete("controller")
    p.delete("page")
    p.delete("format")
    pairs = []
    p.each_pair {|key, value| pairs << "#{key}=#{value}" }
    "/organizations.#{format}?#{pairs.join('&')}"
  end
  
  def website_link_or_disclaimer organization
    return link_to(organization.website, organization.website) unless organization.website.blank?
    return faded("not googled yet") if organization.has_not_been_googled?
    faded("no website found")
  end
  
end
