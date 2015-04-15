function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    var $preview = $('.preview.' + $(input).data('preview'));

    reader.onload = function (e) {
      $preview.css('width', 'auto');
      $preview.css('height', 'auto');
      $preview.attr('src', e.target.result);
    }

    reader.readAsDataURL(input.files[0]);
  }
}

$(".to-preview").change(function(){
  readURL(this);
});
