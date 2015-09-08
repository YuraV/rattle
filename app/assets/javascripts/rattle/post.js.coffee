Rattle.ns('Rattle.Post')

class Rattle.Post
  constructor: (options)->
    @settings = $.extend {}, {
      form: "#new_post"
      categoryPosts: $("#category_posts")
      container: $(".container-fluid")
      voteLink: ".vote_link"
    }, options

    { @form, @categoryPosts, @container, @voteLink } = @settings

    @container.on "submit", @form, (e) =>
      e.preventDefault()
      $.ajax
        url: $(@form).attr('action')
        data: $(@form).serialize()
        method: "POST"
      .success (data)=>
        @categoryPosts.html(data)