# Pin npm packages by running ./bin/importmap

pin "application"
pin "@rails/ujs", to: "https://cdn.skypack.dev/@rails/ujs", preload: true
pin "jquery", to: "https://code.jquery.com/jquery-3.6.0.min.js", preload: true
pin "jquery-ui", to: "https://code.jquery.com/ui/1.12.1/jquery-ui.min.js", preload: true
pin "jquery.fileupload", to: "jquery.fileupload.js"
