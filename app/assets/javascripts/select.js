function initSelect2() {
  $('.select2').select2({
      theme: "bootstrap",
      tags: true,
  });
}

$(document).ready(initSelect2)

$(document).on('cocoon:after-insert', function(e, insertedItem) {
  initSelect2()
});