module DataRequestsHelper
  
  def print_status_color(status)
    if status == DataRequest::FILLED
      "alert-success"
    elsif status == DataRequest::OPEN
      "alert-info"
    elsif status == DataRequest::CANCELLED
      "alert-danger"
    elsif status = DataRequest::EXPIRED
      "alert-warning"
    else
      ""
    end
  end
end
