// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "jquery"
import "jquery-ui"
import "jquery.fileupload"

import Rails from '@rails/ujs';
Rails.start();

$(function(){
  $('#data_request_project_due_date, #data_request_completed_date, #data_request_expires_after').datepicker({ dateFormat: 'yy-mm-dd' });
});

$(function() {
  // Data Request details page: show attachments button or form but not both.
  $("#attachment_button").hide();
  $("#jq_attachment").show();
    
  $('#jq_attachment').fileupload({
    dataType: 'script',
    singleFileUploads: true,
    add: function (e, data) {
      $.each(data.files, function (index, file) {
        var input = $('<input id="attachment[description]" type="text" name="attachment[description]" placeholder="Description" title="attachement file" />').addClass('attachment_description');
      
        var button = $('<button/>').text('Upload').addClass('btn btn-tiny btn-primary pull-right').click(function () {
          data.formData = {"attachment[description]": $(this).siblings("input").val()};
          var jqXHR = data.submit();
          $(this).hide();
          $(this).parent().remove();
        });   

        var close_button = $('<button/>').text('Cancel').addClass('btn btn-tiny pull-right').click(function () {              
          $(this).parent().remove();
          $(this).hide();
        });
  
        var label = $("<h6/>").text("Upload this file?");
        var filename = $('<div/>').append(label).addClass("attachment-upload").append(close_button).append("").append(button).append($('<h4/>').text(file.name)).append(input);
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
});

$(function() {
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
    } else {
      $("#participants_names_box").hide();
    }
  });
});

