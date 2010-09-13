# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def first_name name
    name.split(/\s/)[0] unless name.nil?
  end
  
  def add_brs string
    string.gsub /\n/, "<br/>"
  end
  
  def shorten string, max_length
    if string.length <= max_length
      return string
    end
    return string.slice(0, max_length - 3) + "..."
  end
end
