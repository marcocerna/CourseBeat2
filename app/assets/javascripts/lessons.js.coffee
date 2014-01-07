$ ->
  # New Lesson modal
  $('#new-lesson').click ->
    $('#text-goes-here').empty()
    new_lesson = JST['templates/new_lesson']()
    $('#text-goes-here').append(new_lesson)

  # Category button
  $('body').on 'click', '#new-category', (event) ->
    category = JST['templates/category']()
    $('#categories-list').append(category)

  # Sub Concept button
  $('body').on 'click', '#new-concept', (event) ->
    concept = JST['templates/sub_concept']()
    list = $(this.parentElement.lastElementChild)
    list.append(concept)

  # Submit new lesson
  $('#create-lesson').on 'click', (event) ->
    categories = $('.category-text')
    categoryArray = []

    for category in categories
      categoryArray.push($(category).val())

    debugger
    data = {
      lesson:
        {
          title: $('#new-lesson-text').val()
        }
      categories: categoryArray
    }
    $.post('/lessons', data).done (data) ->
      $('#show-lessons').append(data.title)
      $('.modal').modal('hide')