$(function () {
    $('.Change-DropDown-Icon').on('click', function () {
        $('.glyphicon', this)
          .toggleClass('glyphicon-chevron-right')
          .toggleClass('glyphicon-chevron-down');
    });
});