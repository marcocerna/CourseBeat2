module LessonsHelper

  def create_categories
    params[:categories].each do |info, concepts|
      category = KeyConcept.create(info: info, lesson_id: @lesson.id)
      create_concepts concepts, category unless concepts == "0"
    end
  end

  def create_concepts concepts, category
    concepts.each do |concept|
      SubConcept.create(info: concept, key_concept_id: category.id)
    end
  end

  def get_concepts
    @data = {"lesson" => Lesson.find(params[:id]) }
    categories = KeyConcept.where(lesson_id: @data["lesson"]["id"]).order(:id)
    concepts = []
    categories.each do |cat|
      cat["concepts"] = SubConcept.where(key_concept_id: cat["id"]).order(:id)
      concepts << cat
    end
    @data["categories"] = concepts
  end

  def calculate_rating
    numerator = (@concept.ratingAverage * (@concept.ratingCount - 1)) + params[:value].to_f
    long_num = numerator / @concept.ratingCount
    long_num.round(2)
  end

  def update_categories
    params[:categories].each do |k, cat|
      # Refactor: when new Category is created (probably an if id = nil or something like that)
      category = KeyConcept.find(cat["id"])
      category.update_attributes(info: cat["info"])
    end
    update_concepts
  end

  def update_concepts
    params[:concepts].each do |k, con|
      # Refactor: same as above
      concept = SubConcept.find(con["id"])
      concept.update_attributes(info: con["info"])
    end
  end
end
