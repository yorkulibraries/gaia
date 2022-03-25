module ApplicationHelper
  def is_controller_and_action(c, a = nil)
    if a == nil
      controller_name == c
    else
      controller_name == c && action_name == a
    end
  end
  
  def controller_name
    controller.controller_name
  end
  
  def action_name
    controller.action_name
  end

  def current_path
    path = request.env['PATH_INFO']    
  end
  
  def gaia_version
    "1.0.0"
  end
end
