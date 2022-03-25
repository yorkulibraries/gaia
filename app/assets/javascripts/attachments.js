	
$(function() {

	// Data Request details page: show attachments button or form but not both.
	$("#attachment_button").hide();
	$("#jq_attachment").show();
	
	var button;
	var file_name;
	var name;
		
	$('#jq_attachment').fileupload({
		dataType: 'script',
		singleFileUploads: true,
	    add: function (e, data) {

			$.each(data.files, function (index, file) {

				input = $('<input id="attachment[description]" type="text" name="attachment[description]" placeholder="Description" title="attachement file" />').addClass('attachment_description');
			
				button = $('<button/>').text('Upload')
						.addClass('btn btn-tiny btn-primary pull-right')
		                .click(function () {
						// console.log($(this).siblings("input").val());
							data.formData = {"attachment[description]": $(this).siblings("input").val()};						   
						// data.formData = {"attachment[description]": $(this).parent().find(":input").val()};						   
							jqXHR = data.submit();
							$(this).hide();
							$(this).parent().remove();
		            	});		

				close_button = $('<button/>').text('Cancel')
						.addClass('btn btn-tiny pull-right')
		                .click(function () {							
							$(this).parent().remove();
							$(this).hide();
	       				});
	
				label = $("<h6/>").text("Upload this file?");
				filename = $('<div/>').append(label).addClass("attachment-upload").append(close_button).append("").append(button).append($('<h4/>').text(file.name)).append(input);
				filename.appendTo("#files");
		    });			
			
	    },      
	    start: function (e) { 
				$('#progress').show();
	    },        
	    progress: function (e, data) {
				$.each(data.files, function (index, file) {
					var rate = (data.loaded / data.total) * 100
					$(".bar").css({'font-size': '18px','width': rate + '%'}).text(Math.round(rate) + "% of " + (data.total/1000) + " KBytes ").show();
		         
	       });
	    },        
	    done: function (e, data) {
	      $.each(data.files, function (index, file) {
					$('#progress').hide();
	      });

	    },
	    fail: function (e, data) {
			$('#upload_error').show();
	        $.each(data.files, function (index, file) {
	            $('#upload_error').text("There was an error uploading " + file.name + " file. Thrown: " + data.errorThrown + "Status: " + data.textStatus).show();
	        });
	    }
	});        
		
	intialize_popovers();

});

function intialize_popovers() { 
	$('.delete_attachment').each(function(index) {
		var confirm_delete_id = "#confirmation_attachment_delete_" + $(this).data("attachment-id");
		var content = $(confirm_delete_id).html();


		$(this).data("content", content);
		$(this).click(function() { return false; });						

		$(this).popover({
			placement:'top',	
			trigger: 'click',
			title: "Delete?",
			html: true
		});		
	});	
}

