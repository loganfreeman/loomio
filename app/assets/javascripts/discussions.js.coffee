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
  $("textarea").atWho "@", 
    tpl: "<li id='${id}' data-value='${username}' data-insert='${username}'>${name} <small>${username}</small></li>"
    choose: "data-insert"
    callback: (query, callback) ->
      $.get "/users/mentions.json", q: query, ((result) ->
          console.log(result)
          names = _.toArray(result)
          names = _.map names, (name) ->
            _.toArray(name)
          callback _.toArray(names)
      ), "json"

