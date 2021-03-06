// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require twitter/bootstrap
//= require_tree .
//= require products
//= require mustache
//= require ICanHaz
//= require jquery.form
//= require add_new_account


// for getting the product id from the find function
var product_id;


//script for the product context
$(function() {
    $('#product_context_start_time').datetimepicker({
      duration: '',
      showTime: true,
      constrainInput: false,
      dateFormat: "dd-mm-yy"
     });
     
    $('#product_context_end_time').datetimepicker({
      duration: '',
      showTime: true,
      constrainInput: false,
      dateFormat: "dd-mm-yy"
     });
     
    $('#holiday_holiday_date').datetimepicker({
      duration: '',
      showTime: true,
      constrainInput: false,
      dateFormat: "dd-mm-yy"
     });
     
     
    $("select").change(function() {
        var selectValue = $("#product_context_context_type").val();

        if (selectValue == "Time") {
            //$(".extra_field_input").show();
            $(".extra").show();
        } else {
            //$(".extra_field_input").hide();
            $(".extra").hide();
        };
    });

});
function test(){
    if(($("#product_context_start_time").val()=="" || $("#product_context_end_time").val()=="") && $("#product_context_context_type").val()=="Time" ) {
        alert('Time fields should not be blank');
        return false;
    }
}

//update invoice
function update_row_number(i)
  {
    row_no = i;
    row_len = i;
  }

function calculate(no)
 {

 var quantity= $('#qty'+no).val();
 var unitprice=$('#up'+no).val();
$('#total'+no).val(quantity*unitprice);
   calculate_total();
 }

 function calculate_total()
 {
         var sum=0;
          for (i=1;i<=row_len;i++)
          {
              if($('#total'+i).val())
              sum=parseFloat(sum) + parseFloat($('#total'+i).val());
          }
      $('#gtotal').val(parseFloat(sum));
 }
var row_no=0;
var row_len=0;
function addRow(tbl,row){
  //row count
   row_no++;
   row_len++;

   var tick = String(row_no);

   if (row_no>=0){

  //Declaring text boxes

  
 var textbox ='<input type="text" style="width:100px" class="autocomplete_field" def_ref='+row_no+'  name="pn[]" id=pn'+tick+'>';
  var textbtn = '<input type="radio" name="type_sel'+tick+'" onclick="searching_by_date('+row_no+')" def_ref='+row_no+' id =date_'+tick+' value="1">'+'Now'+'<input type="radio" name="type_sel'+tick+'" onclick="searching_by_time('+row_no+')" def_ref='+row_no+' value="0" id =time_select'+tick+' ">'+'Time';
 var textbox2 = '<input type="text" style="width:50px" name="qty[]" onblur="calculate('+tick+');"  value="1" id=qty'+tick+'>';
 var textbox3 = '<input type="text" style="width:100px"  name="up[]" onblur="calculate('+tick+')"   value="0.0" id=up'+tick+'>';
 var textbox4 = '<input type="text" style="width:100px" readonly ="true"  name="total[]" value="0.0" id=total'+tick+'>';

  //delete button
   var stop = '<input type="button" id="delete"value="Delete"  onclick="deleteRow(this);" >';

  //Inserting textboxes into table cells

   var tbl = document.getElementById(tbl);
   var rowIndex = document.getElementById(row).value;
   var newRow = tbl.insertRow(row_no);
   var newCell = newRow.insertCell(0);
   newCell.innerHTML = textbox;
   var newCell = newRow.insertCell(1);
   newCell.innerHTML = textbtn;
   var newCell = newRow.insertCell(2);
   newCell.innerHTML = textbox2;
   var newCell = newRow.insertCell(3);
   newCell.innerHTML = textbox3;
   var newCell = newRow.insertCell(4);
   newCell.innerHTML = textbox4;   
   var newCell = newRow.insertCell(5);
   newCell.innerHTML = stop;
   }
   searching_by_time(row_no)
 }
//Delete Function
 function deleteRow(r)
 {
     if(confirm("Are you sure want to remove line item?")==true)
     {
         var i=r.parentNode.parentNode.rowIndex;
         document.getElementById('TableMain').deleteRow(i);
        //calculate_delete(r);
         row_no-=1
         calculate_total();
     }
     else
     return false;
 }





function searching(val){
  var getval=document.getElementById("keywords").value;
  
  
    $.get("find", { value: getval, name: "fstech" },
   function(data) {
  //var returndata = data;
   $('#displayed').html(data);
    // alert(data);
    //alert($('#values1').val());
    //var name= $('#values1').text();
    //var unitprice=$('#values2').text();
    //document.getElementById('name').value=name;
    //document.getElementById('unitprice').value=unitprice;
    //  alert(data);
   });
}

function cal()
{
var quantity= $('#quantity').val();
   var unitprice=$('#unitprice').val();
   $('#total').val(quantity*unitprice);
}






//auto complete

function selectItem(li) {  }

function formatItem(row) { return row; }




$(document).ready(function() {

    if (parseInt($("#sum").val()))
    {
        $("#gtotal").val(parseInt($("#sum").val()));
    }


    $("#keywords1").autocomplete('find', {
                    minChars: 1,
                    max: 20,
                    mustMatch: false,
                    matchContains: false,
                    scrollHeight: 300,
                    //multiple: true,
                    //multipleSeparator: ", ",
                    width: 200
                });

//
//  $("#keywords1").autocomplete("find",
//        { minChars:2, matchSubset:1, matchContains:1, cacheLength:10,
//        onItemSelect:selectItem, formatItem:formatItem, selectOnly:1
//        });

    $("#keywords1").result(function(event, data, formatted)
                {

                    //alert(data[0]);
                    //alert(data[1]);
                   addRow('TableMain','row1');
                   $("#pn"+row_len).val(data[0]);
                   $("#up"+row_len).val(data[1]);
                    //n=data[1];
                    $("#gtotal").val(parseInt(data[1])+parseInt($("#gtotal").val()));
                   // alert($("#gtotal").val());
                    $("#total"+row_len).val((data[1]));


                });
                
 
    //automcomplete for the product name field
    $('.autocomplete_field').live('focus', function() {



        $("#pn"+$(this).attr('def_ref')).autocomplete('find', {
                    minChars: 1,
                    max: 20,
                    mustMatch: false,
                    matchContains: false,
                    scrollHeight: 300,
                    //multiple: true,
                    //multipleSeparator: ", ",
                    width: 200
                });


        $("#pn"+$(this).attr('def_ref')).live('result', function(event, data, formatted)
                {
                  $("#pn"+$(this).attr('def_ref')).val(data[0]);
                  $("#up"+$(this).attr('def_ref')).val(data[1]);
                  $("#qty"+$(this).attr('def_ref')).val(1);
                 
                   product_id = data[2];
                   calculate($(this).attr('def_ref'));

                });

  });
});



//function for picking the unit price based on product context time


  function searching_by_time(v)
  {
 
   $('#time_select'+v).datetimepicker({
      duration: '',
      showTime: true,
      constrainInput: false,
      dateFormat: "dd-mm-yy"
     });
   
   $(".ui-datepicker-close").click(function(){
    
     time_val=$('#time_select'+v).val();
     
     if (time_val !=0) {
      $.get("find_context", { value: time_val, id: product_id },
      function(data) {
      //alert("hii");
        $("#up"+v).val(data);
        alert(data);
      });  
        
      }
      else{
      alert("select the date and time");
      }
     
   }); 
  }

function searching_by_date( v)
  {
   //alert(product_id);
    $.get("find_context", { id: product_id },
      function(data) {
     $("#up"+v).val(data);
        alert(data);
      });  
     
  }

