module ApplicationHelper
  def flash_class(level)
  	case level
  	when :notice then 'info'
  	when :error then 'error'
  	when :alert then 'warning'
  	end
  end

  def page_id
  	"#{controller_path.parameterize}-#{action_name}"
  end
  
end
