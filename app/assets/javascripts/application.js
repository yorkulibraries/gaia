// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery3
//= require popper
//= require bootstrap
//= require rails-ujs
//= require jquery-ui
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require_self


$(function(){
  $('#data_request_project_due_date, #data_request_completed_date, #data_request_expires_after').datepicker({ dateFormat: 'yy-mm-dd' });
});

$(function() {
  $("#jq_attachment").show();
    
  $('#jq_attachment').fileupload({
    dataType: 'script',
    singleFileUploads: true,
    add: function (e, data) {
      $.each(data.files, function (index, file) {
        var id = file.name + Date.now();
        var inputId = 'input_' + id;

        var label = $('<label class="form-label">Description</label>').attr('for', inputId);
        var input = $('<input class="form-control" type="text" name="attachment[description]">').attr('id', inputId);
        
        var submit = $('<button class="btn btn-sm btn-primary">').text('Upload').click(function () {
          data.formData = {"attachment[description]": $(this).parent().siblings("input").val()};
          var jqXHR = data.submit();
          $(this).parent().parent().remove();
        });   

        var cancel = $('<button class="btn btn-secondary btn-sm">').text('Cancel').click(function () {      
          $(this).parent().parent().remove();
        });
  
        var prompt = $('<p class="my-3">Upload this file?</p>');
        var filename = $('<p class="mt-3 fw-bold">').text(file.name);
        var buttons = $('<div>').append(submit).append(" ").append(cancel);
        
        var upload = $('<div class="attachment-upload">').append(filename).append(label).append(input).append(prompt).append(buttons);
        
        $('#files').append(upload);
      });
    },      
    start: function (e) { 
      $('.progress-bar').css({'width': '0%'}).text('');
      $('#progress').removeClass('invisible');
    },
    progress: function (e, data) {
      $.each(data.files, function (index, file) {
        var rate = (data.loaded / data.total) * 100;
        $('.progress-bar').css({'width': rate + '%'}).text(Math.round(rate) + "% of " + data.total/1000000 + " MB");
      });
    },        
    done: function (e, data) {
      $.each(data.files, function (index, file) {
        $('.progress-bar').css({'width': '0%'}).text('');
        $('#progress').addClass('invisible');
      });
    },
    fail: function (e, data) {
      $.each(data.files, function (index, file) {
        $('#upload_error').text("There was an error uploading " + file.name + " file. Thrown: " + data.errorThrown + "Status: " + data.textStatus);
      });
      $('#upload_error').removeClass('invisible');
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