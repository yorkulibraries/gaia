$(document).ready(function() {
	
	// When showing a form if request is for a course, show course info, else show project description

	
	$("a.project_or_course_link").click(function() { 
		var which = $(this).data("which");
		
		if (which == "course") {
			$("#course_info_box").show();
			$("#project_description_box").show();
			$("#data_request_course").val(true);
		} else {
			$("#course_info_box").hide();
			$("#project_description_box").show();
			$("#data_request_course").val(false);
		}
		
		$("#course_or_project_selector li.active").removeClass("active");			
		
		$(this).parent().addClass("active");
		
		return false;
	});
	

	if ($("#data_request_participants_count").val() > 1) {
			$("#participants_names_box").show();
	}
	$("#data_request_participants_count").change(function() {

		if ($("#data_request_participants_count").val() > 1) {
			$("#participants_names_box").show();
		}else {
			$("#participants_names_box").hide();
		}
		
	});
	
});

