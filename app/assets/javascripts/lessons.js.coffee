$ ->
  # Navbar Link to Home
  $('.navbar-brand').on 'click', (event) ->
    console.log "This should load the home page."
    $('#render-data').slideUp()
    $('#welcome-div').slideDown()

  # Toggle View Lessons
  $('#toggle-show-lessons').on 'click', (event) ->
    $('#welcome-div').slideUp()
    $('#show-lessons').toggleClass('hide')

  ############################
  ### Creating New Lessons ###
  ############################

  # New Lesson modal
  $('#new-lesson').on 'click', (event) ->
    $('#modal-text').empty()
    $('#modal-text').append JST['templates/new_lesson']()

  # Category button
  $('body').on 'click', '#new-category', (event) ->
    $('#categories-list').append JST['templates/category'](" ")

  # Sub Concept button
  $('body').on 'click', '#new-concept', (event) ->
    list = $(this.parentElement.lastElementChild)
    list.append JST['templates/sub_concept']()

  # Submit new lesson
  $('#create-lesson').on 'click', (event) ->
    data =
      lesson: { title: $('#new-lesson-text').val() }
      categories: createConceptObj($('.category-text'), $('.concept-text'))
    $.post('/lessons', data).done (data) ->
      $('#show-lessons').append JST['templates/lesson_small'](data)
      $('.modal').modal('hide')

  createConceptObj = (categories, concepts) ->
    conceptArray = []
    dataObj = {}
    for category in categories
      cat = $(category).val()
      concepts = $(category).parent().find('.concept-text')
      concepts = 0 unless concepts.val()
      for concept in concepts
        conceptArray.push($(concept).val())
      dataObj[cat] = conceptArray
      dataObj[cat] = 0 if `concepts === 0`
      conceptArray = []
    return dataObj

  #####################################
  ### Show Lesson and Update Rating ###
  #####################################

  # Show Lesson
  $('body').on 'click', '.show-lesson', (event) ->
    lessonID = $(this)[0].id
    $.get('/lessons/' + lessonID).done (data) ->
      $('#render-data').data('lesson-data', data)  # IMPORTANT: We store data here so we don't need to ajax for editing later
      $('#index').slideUp()
      $('#render-data').append(JST['templates/show_lesson'](data)).slideDown()

  # Back to Main
  $('body').on 'click', '.back-to-main', (event) ->
    backToMain()

  backToMain = ->
    $('#render-data').slideUp()
    $('#index').slideDown()
    setTimeout $('#render-data').empty(), 500

  # Only one radio button can be selected at a time
  $('body').on 'click', ':radio', (event) ->
    $radios = $(this).parent().children('input')
    $radios.not(this).prop('checked', false)

  # Update rating
  $('body').on 'click', '.submit-rating', (event) ->
    event.preventDefault()
    selected = $(this).parent().children 'input:checked'
    data =
      value: selected.val()
      id: selected[0].id
    $.post('/lessons/vote', data).done (data) ->
      $('#rating-' + data.id).html "Rating: " + data.ratingAverage
      $('#count-' + data.id).html "Vote Count: " + data.ratingCount

  ###############################
  ### Edit and Delete Lessons ###
  ###############################

  # Update Lesson - Retrieve Data
  $('body').on 'click', '#update-lesson', (event) ->
    data = $('#render-data').data('lesson-data')       # Instead of ajax call, we use data already stored in DOM
    $('#edit-modal-text').empty()
    $('#edit-modal-text').append JST['templates/edit_lesson'](data)

  # Update Lesson - Submit Data
  $('body').on 'click', '#submit-updated-lesson', (event) ->
    data =
      lesson:
        id:       $('#render-data').data('lesson-data').lesson.id
        title:    $('#new-lesson-text').val()
      categories: updateCategoryObj $('.category-text')
      concepts:   updateConceptObj $('.concept-text')
    $.ajax
      url: "/lessons/" + data.lesson.id
      type: "PUT"
      data: data
      success: (result) ->
        $('#render-data').data('lesson-data', result)
        $('#render-data').empty().append(JST['templates/show_lesson'](result))
        $('.modal').modal('hide')

  updateCategoryObj = (categories) ->
    catArray = []
    for category in categories
      catObj =
        id: $(category).attr 'id'
        info: $(category).val()
      catArray.push catObj
    return catArray

  updateConceptObj = (concepts) ->
    conArray = []
    for concept in concepts
      conObj =
        id: $(concept).attr 'id'
        info: $(concept).val()
      conArray.push conObj
    return conArray

  # Delete Lesson
  $('body').on 'click', '#delete-lesson', (event) ->
    event.preventDefault()
    id = this.parentElement.id
    if confirm "Are you sure you want to delete this lesson?"
      $.ajax
        url: "/lessons/" + id
        type: "DELETE"
        success: (result) ->
          $('#' + id).remove()
          backToMain()