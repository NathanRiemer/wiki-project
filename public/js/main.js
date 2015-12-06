$('document').ready(function() {
  $commentToggler = $('.comment.toggler');
  $commentsDiv = $('.comments');
  $commentToggler.click(function() {
    $commentsDiv.toggle();
  });
});