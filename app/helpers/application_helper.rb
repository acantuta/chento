module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Chento"
    end
  end
end
