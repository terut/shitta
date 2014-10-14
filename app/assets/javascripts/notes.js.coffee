class ShittaFav
  constructor: ($element) ->
    @favs = []
    @timer
    @element = $element
  favorite: () ->
    clearTimeout(@timer)
    @favs.push("")
    favs = @favs
    element = @element
    html = $('#dummy_favorited').clone(true).html()
    $('#favorited').append html

    hoge = ->
      console.log 'ajax' + favs.length
      note_id = $(element).data('note-id')

      $.ajax({
        type: 'POST'
        url: '/notes/' + note_id + '/favorites'
        data: { 'point': favs.length }
      }).done ->
           favs.length = 0
           console.log 'request success'
        .fail ->
           console.log 'request error'

    @timer = setTimeout hoge,700

$ ->
  $(document).on "keypress", "input:not(.allow_submit)", (event) -> event.which != 13

  $ele = $('#fav')
  if ($ele)
    fav = new ShittaFav $ele

  $ele.click ->
    fav.favorite()

  $('#note_tag_list').tagsinput({
    maxTags: 5,
    maxChars: 30,
    trimValue: true,
    typeahead: {
      # TODO refactoring
      source: (query) ->
        return $.get("/tags/autocomplete.json?q=" + query)
    }
  })
