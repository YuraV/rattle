jQuery(document).ready ($) ->
  $.extend $.facebox.settings,
    loadingImage: '/assets/facebox/loading.gif',
    closeImage  : '/assets/facebox/closelabel.png'

  $('a[rel*=facebox]').facebox()
