module LessonsHelper

  def create_categories
    params[:categories].each do |info, concepts|
      category = KeyConcept.create(info: info, lesson_id: @lesson.id)
      create_concepts concepts, category if concepts
    end
  end

  def create_concepts concepts, category
    concepts.each do |concept|
      SubConcept.create(info: concept, key_concept_id: category.id)
    end
  end

  def get_concepts
    categories = KeyConcept.where(lesson_id: @data["lesson"].id)
    concepts = {}

    categories.each do |cat|
      concepts[cat.info] = SubConcept.where(key_concept_id: cat.id)
    end

    @data["categories"] = concepts
  end

  def calculate_rating
    numerator = (@concept.ratingAverage * (@concept.ratingCount - 1)) + params[:value].to_f
    numerator / @concept.ratingCount
  end

end
