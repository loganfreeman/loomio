# Edit title
$ ->
  if $("body.discussions.show").length > 0
    $("#edit-title").click((event) ->
      $("#discussion-title").addClass('hidden')
      $("#edit-discussion-title").removeClass('hidden')
      event.preventDefault()
    )
    $("#cancel-edit-title").click((event) ->
      $("#edit-discussion-title").addClass('hidden')
      $("#discussion-title").removeClass('hidden')
      event.preventDefault()
    )
    $(".edit-discussion-description").click (e)->
      $(".discussion-description-helper-text").toggle()

$ ->
  $("textarea").atWho "@", (query, callback) ->
      console.log("@who") 
      $.ajax 
        url: "/users/mentions.json"
        data: q: query 
        done: (data) ->
          console.log("in callback")
          console.log(data)
          names = $.parseJSON(data)
          console.log(names)
          callback names
