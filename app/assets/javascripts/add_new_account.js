$(document).ready(function() {
  $("#dialog" ).dialog({
    autoOpen: false,
    title: 'New Account',
    show: "blind",
    width: 450,
    height: 343,
    modal: true
  });


  $('#close_dialog').click(function() {
     $('#dialog').dialog('close');
   });


  $('#lazy_model').click(function(){ 
    $('.clearme').val("");
    $('#error-valid').text("");
    $("#dialog" ).dialog( "open" );
    $('#create_acc').unbind('click').bind('click',function(){
     res= $.ajax({
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      url: "/accounts",
      type: "POST",
      data: $('#add_acc').serialize(),
      dataType: "json",
      error: function(e){
        $('#error-valid').text(""); 
          res = jQuery.parseJSON(e.responseText);
          $.each(res,function(key, val){ 
            $.each(val, function(e, a_val){ 
              $('#error-valid').append('<br />' + key + ' ' + a_val);
             }) 
          });
      },
      success: function(product_data){
        $("#dialog" ).dialog( "close" );
        $('#invoice_account_id').append('<option>'+product_data.display_name+'</option>');
        $('#error-valid').text('');
        
        $('#success').append("You are successfully added new account"+ " "+ "'" + product_data.display_name + "'.");
        return false;
      }
    });
     return false; 
    });

  });

});

$(".close_notice").click(function(){
  $(".alert-message").hide();
});


