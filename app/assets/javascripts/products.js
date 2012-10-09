var res;

$(document).ready(function(){

	$('#add_product').click(function(){
		$('.new-product').show();
    txt_val = $("input:text");
    console.log(txt_val[0]);
    
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
  			// console.log(res.key);
  			// var r=res.key + ""
  			// $('.new-product').append('<br />' + r);
  			
  		},
  		success: function(product_data){
        console.log(product_data);
  			console.log('success')
  			// $('.zebra-striped').append("<tr><td>"+ product.name +"</td><td>"+ product.unit_price +"</td></tr>")
  			var product = ich.product(product_data);
  			console.log(product);
  			$('.zebra-striped').append(product);
        $('#error-valid').text('');
        $('#error-valid').append("Your are successfully added "+ product_data.name);
        $('.new-product').hide();
     	}
	  });
	  return false;
	});
});