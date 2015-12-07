$(document).ready(function() {
  $commentToggler = $('.comment.toggler');
  $commentsDiv = $('.comments');
  $commentToggler.click(function() {
    $commentsDiv.toggle();
  });

  $prevDiffToggler = $('.diff-button.prev');
  $prevDiff = $('.prev-diff');
  $prevDiffToggler.click(function() {
    $prevDiff.toggle();
  });

  $currDiffToggler = $('.diff-button.curr');
  $currDiff = $('.curr-diff');
  $currDiffToggler.click(function() {
    $currDiff.toggle();
  });
});