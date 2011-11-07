$(function() {
  $('#media_category_id').change(function(e) {
    category_id = $(this).val();
    $('#media_subcategory_id').load( '/subcategories?category_id=' + category_id );
  });
});