(->
  scope = @
  scope.Rattle= {
    namespace: ->
      o = d = null
      $.each arguments, (i, v) ->
        d = v.split('.')
        o = scope[d[0]] = scope[d[0]] || {}
        $.each d.slice(1), (i, v2) ->
          o = o[v2] = o[v2] || {}
  }
  scope.Rattle.ns = scope.Rattle.namespace
)()