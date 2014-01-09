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
    dataObj = createConceptObj($('.category-text'), $('.concept-text'))
    data =
      lesson: { title: $('#new-lesson-text').val() }
      categories: dataObj
    $.post('/lessons', data).done (data) ->
      $('#show-lessons').append(JST['templates/lesson_small'](data))
      $('.modal').modal('hide')

  createConceptObj = (categories, concepts) ->
    conceptArray = []
    dataObj = {}
    for category in categories
      cat = $(category).val()
      concepts = $(category).parent().find('.concept-text')
      for concept in concepts
        conceptArray.push($(concept).val())
      dataObj[cat] = conceptArray
      conceptArray = []
    return dataObj

  # Show Lesson
  $('body').on 'click', '.lesson-small', (event) ->
    lessonID = $(this)[0].id
    $.get('/lessons/' + lessonID).done (data) ->
      $('#index').slideUp()
      $('#render-data').append(JST['templates/show_lesson'](data))
      $('#render-data').slideDown()

  # Back to Main
  $('body').on 'click', '.back-to-main', (event) ->
    $('#index').slideDown()
    $('#render-data').slideUp()
    $('#render-data').empty()

  # Only one radio button can be selected at a time
  $('body').on 'click', ':radio', (event) ->
    $radios = $(this).parent().children('input')
    $radios.not(this).prop('checked', false)

  # Update rating
  $('body').on 'click', '.submit-rating', (event) ->
    selected = $(this).parent().children('input:checked')
    data =
      value: selected.val()
      id: selected[0].id
    $.post('/lessons/vote', data).done (data) ->
      $(this).parent().children('.current-rating').empty()
