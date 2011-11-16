$(function() {
  
  $('.flash .close').click(function(e) {
    e.preventDefault();
    $(this).parent().slideUp('fast');
  });
  
});