

$(document).ready(function(){

  $("#submit").click(function(){
    $.post('/walls', {message: {content: $("#message").val(), to_id: $("#to").val()}}, function(){
      $("#message").val('');
    });
  }) 
});
