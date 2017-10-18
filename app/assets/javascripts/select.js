function addFields(component, container) {
  container = container || $('body')
  container.find('a.add_fields[data-association="'+component+'"]').first().click()
}
function initSelect2() {
  $('.select2').select2({
      theme: "bootstrap",
      tags: true,
  });
}

$(document).ready(initSelect2)
$(document).ready(function(){
  if ( $('.nested-fields .step').length == 0) {
    addFields('step')
  }
})

$(document).on('cocoon:after-insert', function(e, insertedItem) {
  initSelect2()

  if (insertedItem.children().first().hasClass('step')) {
    addFields('component', insertedItem)
  }
});