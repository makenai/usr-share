$(function() {
  $('#media_category_id').change(function(e) {
    category_id = $(this).val();
    if ( category_id ) {
      $('#media_subcategory_id').load( '/subcategories?category_id=' + category_id );
      $('#subcategory_category_id').val( category_id );
      $('#quick_subcategory').show();
    } else {
      $('#media_subcategory_id').text('');
      $('#subcategory_category_id')[0].removeAttribute('value');      
      $('#quick_subcategory').hide();
    }
  });

  $('#quick_category').submit(function(e) {
    e.preventDefault();
    var fields = $(this).serialize(),
      form = this;
    $.post('/categories', fields, function(data) {
      if ( data.error ) {
        alert( data.error );
      } else {
        $('#media_category_id').append('<option value="' + data.category.id + '">' + data.category.code + 
          ' - ' + data.category.name + '</option>').val( data.category.id ).change();
        $('input[type="text"]', form).val('');
      }
    });
  });

  $('#quick_subcategory').submit(function(e) {
    e.preventDefault();
    var fields = $(this).serialize(),
      form = this;
    $.post('/subcategories', fields, function(data) {
      console.log( data );
      if ( data.error ) {
        alert( data.error );
      } else {
        $('#media_subcategory_id').append('<option value="' + data.subcategory.id + '">' + data.subcategory.code + 
          ' - ' + data.subcategory.name + '</option>').val( data.subcategory.id );
        $('input[type="text"]', form).val('');
      }
    });
  });  
  
});

