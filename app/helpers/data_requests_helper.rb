module DataRequestsHelper
  
  def print_status_color(status)
    if status == DataRequest::FILLED
      "success"
    elsif status == DataRequest::OPEN
      "info"
    elsif status == DataRequest::CANCELLED
      "danger"
    elsif status = DataRequest::EXPIRED
      "warning"
    else
      ""
    end
  end
end
