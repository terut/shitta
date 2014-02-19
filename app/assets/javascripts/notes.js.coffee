class ShittaFav
  constructor: ($element) ->
    @favs = []
    @timer
    @element = $element
    console.log $element
  favorite: () ->
    clearTimeout(@timer)
    @favs.push("")
    favs = @favs
    hoge = ->
      console.log 'ajax' + favs.length
    @timer = setTimeout hoge,1000

$ ->
  $ele = $('#fav')
  if ($ele)
    fav = new ShittaFav @

  $ele.click ->
    fav.favorite()
