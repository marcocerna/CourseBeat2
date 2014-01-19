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

end
