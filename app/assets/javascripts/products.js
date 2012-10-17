var res;
$(document).ready(function(){
	$('#add_product').click(function(){
	try{	$('.new-product').show();
    $('.clearme').val("");
    $('#error-valid').text('');
  }
  catch(e){
    console.log(e);
  }
  	return false;
	});

	$('.new-product').live('submit', function() {
    $('#error-valid').text('');
    res = $.ajax({
  		url: "/products",
  		type: "POST",
  		data: $(this).serialize(),
  		dataType: "json",
  		error: function(e){
  			// console.log(e);
  			 res = jQuery.parseJSON(e.responseText);
  			 $.each(res,function(key, val){ console.log(val);$.each(val, function(e, a_val){ 
 				$('#error-valid').append('<br />' + key + ' ' + a_val);
  			 	console.log(key + ' ' + a_val)}) });
  		},
  		success: function(product_data){
  			var product = ich.product(product_data);
  			$('.zebra-striped').append(product);
        $('#error-valid').text('');
        $('#error-valid').append("Your are successfully added "+ product_data.name);
        $('.new-product').hide();
     	}
	  });
	  return false;
	});
});