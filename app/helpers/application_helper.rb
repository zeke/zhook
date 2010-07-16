module ApplicationHelper
  
  def flash_messages 
    flash.keys.map { |key| content_tag( :div, flash[key], :class => "flash_message #{key}" ) if flash[key] }.join
  end
  
  def pagination_summary(c)
    first_item = c.total_entries.zero? ? 0 : ((c.current_page-1)*c.per_page)+1
    last_item = [(c.per_page*c.current_page), c.total_entries].min
    "#{first_item}-#{last_item} of #{c.total_entries}"
  end

  # Use words if within the last week
  # otherwise use date (show year if not this year)
  def time_ago_in_words_or_date(date,options={})
    return nil unless date
    if (Time.now-date)/60/60/24 < 7
      time_ago_in_words(date) + " ago"
    elsif date.year == Time.now.year
      options[:short] ? date.strftime("%m/%d %I:%M%p") : date.to_s(:short)
    else
      options[:short] ? date.strftime("%m/%d/%y") : date.to_s(:medium)
    end
  end
  
  def phone_number number
    return number if number.blank? || number.size != 10
    a = number[0, 3]
    b = number[3, 3]
    c = number[6, 4]
    "(#{a}) #{b}-#{c}"
  end
  
  def emailify email
    a = email.split(":").last.strip.split("?").first
    link_to a, a
  end
  
  def phone_or_email_or_failure content, kind
    return content if kind == "failure"
    return phone_number(content) if kind == "phone"
    emailify content
  end
  
  def faded_if_zero number
    number.zero? ? faded(number) : number
  end
  
  def faded string
    "<span class=\"faded\">#{string}</em>"
  end

end
