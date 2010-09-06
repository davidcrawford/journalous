# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def first_name name
    name.split(/\s/)[0] unless name.nil?
  end
end
