Rattle.ns('Rattle.Votes')

class Rattle.Votes
  constructor: (options)->
    @settings = $.extend {}, {
      voteLink: ".vote_link"
      container: $(".container-fluid")
    }, options
    # resource comes from outside  ( options ) because it is different for 2 class invocation
    # on show page and on index page
    { @resource, @voteLink, @container} = @settings

    @container.on "click", @voteLink, (event)=>
      event.preventDefault()
      $this = $(event.currentTarget)
      $.post $this.attr('href')
      .success (data)=>
        @resource.html(data)

      return false
