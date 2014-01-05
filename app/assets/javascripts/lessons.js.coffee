$ ->
  # New Lesson modal
  $('#new-lesson').click ->
    $('#text-goes-here').empty()
    new_lesson = JST['templates/new_lesson']()
    $('#text-goes-here').append(new_lesson)

  $('body').on 'click', '#new-category', (event) ->
    alert "Category button clicked!"

  # Submit new lesson
  $('#create-lesson').on 'click', (event) ->
    lesson = {
      lesson:
        {
          title: $('#new-lesson-text').val()
        }
    }
    $.post('/lessons', lesson).done (data) ->
      $('#show-lessons').append(data.title)
      $('.modal').modal('hide')