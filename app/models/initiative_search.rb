class InitiativeSearch
  
  attr_accessor :initiatives
  
  def initialize(conditions = nil, page = 1)
    @initiatives ||= find_initiatives conditions, page
  end
  
  def find_initiatives(conditions, current_page)
    @initiative_search = Initiative
    if conditions
      find_by_title conditions[:title] if conditions[:title]
      find_by_description conditions[:description] if conditions[:description]
      find_by_topic_name conditions[:topic_name] if conditions[:topic_name]
      find_by_representative conditions[:representative] if conditions[:representative]
      find_by_keywords conditions[:keywords] if conditions[:keywords]
    end
    @initiative_search.page(current_page)
  end
  
  private
  
  def find_by_title(title_to_find)
    @initiative_search = @initiative_search.where('title LIKE ?',"%#{title_to_find}%") if title_to_find
  end
  
  def find_by_description(description_to_find)
    @initiative_search = @initiative_search.where('description LIKE ?',"%#{description_to_find}%") if description_to_find
  end
  
  def find_by_topic_name topic_name
    @initiative_search = @initiative_search.joins(:topics).where('topics.name LIKE ?',"%#{topic_name}%") if topic_name
  end
  
  def find_by_representative representative_name
    @initiative_search = @initiative_search.joins(:representative).where('representatives.name LIKE ?',"%#{representative_name}%") if representative_name
  end
  
  def find_by_keywords keywords
    @initiative_search = @initiative_search.where('title LIKE ? OR description LIKE ?',"%#{keywords}%", "%#{keywords}%") if keywords
  end
  
end