var res;
function invoive_acc() {
  jQuery('#invoice_created_at').datetimepicker({
    duration: '',
    dateFormat: 'dd-mm-yy',
    showTime: true
  });
  var wWidth = $(window).width();
$('#new_account').dialog({
    modal: true,
    autoOpen: false,
    title: "New Account",
    width: wWidth*0.4,
    autoResize:true,
   // position: [300, 250],
    buttons: {
         Cancel: function() {
          $(this).dialog("close");
        }
    }
});
   $('#new_account').dialog("open");
}

function add_new_acc() {
  $('#new_account').bind('submit', function(e) {
    alert("h");
      e.preventDefault(); // <-- important
      add_new_acc();
});

}
function add_new_acc(){
    $('#new_account').ajaxForm({
          success: function(responseText, statusText){
            $('#account_display_name').val("");
          //$('#new_account').ajaxForm().resetForm();
            $('#new_account').dialog("close");
            $('#new_account').resetForm();
          }
          // return false;
      });
}
//}); 

$(document).ready(function() {
  $("#dialog" ).dialog({
    autoOpen: false,
    show: "blind",
    width: 450,
    height: 280
  });


  $('#close_dialog').click(function() {
$('#dialog').dialog('close');
});


  // $(".primary").click(function(event){
  //   $('#new_account').dialog("close");
  //   });

  $('#lazy_model').bind('click', function(){ 
    $('.clearme').val("");
    $("#dialog" ).dialog( "open" );
    $('#create_acc').live('click',function(){
     res= $.ajax({
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      url: "/accounts",
      type: "POST",
      data: $('#add_acc').serialize(),
      dataType: "json",
      error: function(e){
        // console.log(e);
         res = jQuery.parseJSON(e.responseText);
         $.each(res,function(key, val){ console.log(val);$.each(val, function(e, a_val){ 
        $('#error-valid').append('<br />' + key + ' ' + a_val);
          console.log(key + ' ' + a_val)}) });
      },
      success: function(product_data){
        $("#dialog" ).dialog( "close" );
        $('#invoice_account_id').append('<option>'+product_data.display_name+'</option>');
        $('#error-valid').text('');
        $('#error-valid').append("Your are successfully added "+ product_data.display_name);
        
      }
    });
     return false; 
    });

  });

});

$(".close_notice").click(function(){
  $(".alert-message").hide();
});


 //$('#new_account').bind('submit', function(e) {
   //     e.preventDefault(); // <-- important
     //   $(this).ajaxForm({
       //   success: function() {
         //   $('#new_account').resetForm();
            //$('#new_account').on('submit', false);
          //}               
       // });
      //});  

//document.location.href = '/path'; //relative to domain