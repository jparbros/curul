class RepresentativeSearch

  attr_accessor :representatives

  def initialize(conditions = nil, page = 1)
    @representatives ||= find_representatives conditions, page
  end

  def find_representatives(conditions, current_page)
    @representative_search = Representative
    if conditions
      find_by_name conditions[:name] if conditions[:name] && !conditions[:name].blank?
      find_by_state conditions[:state] if conditions[:state] && !conditions[:state].blank?
      find_by_political_party conditions[:political_party] if conditions[:political_party] && !conditions[:political_party].blank?
      find_by_commision(conditions[:commision]) if conditions[:commision] && !conditions[:commision].blank?
      find_by_email(conditions[:email]) if conditions[:email] && conditions[:email].present?
      find_by_twitter(conditions[:twitter]) if conditions[:twitter] && conditions[:twitter].present?
    end
    (current_page == 'none')? @representative_search : @representative_search.page(current_page)
  end

  private

  def find_by_name(name)
    @representative_search = @representative_search.where('representatives.name iLIKE ?',"%#{name}%") if name
  end

  def find_by_state state
    @representative_search = @representative_search.joins(:region).where('regions.id = ?', state) if state
  end

  def find_by_political_party political_party
    @representative_search = @representative_search.joins(:political_party).where('political_parties.id = ?', political_party) if political_party
  end

  def find_by_commision(commision_name)
    @representative_search = @representative_search.joins(:commissions).where('commissions.name = ?', commision_name) if commision_name
  end
  
  def find_by_email(email)
    @representative_search = @representative_search.where('representatives.email iLIKE ?', "%#{email}%") if email
  end
  
  def find_by_twitter(twitter)
    @representative_search = @representative_search.where('representatives.twitter iLIKE ?', "%#{twitter}%") if twitter
  end

end