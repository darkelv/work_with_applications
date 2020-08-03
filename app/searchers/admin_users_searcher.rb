class AdminUsersSearcher
  attr_accessor :filter

  def initialize filter
    @filter = filter
  end

  def perform
    scope = base_scope
    scope = add_keywords_condition(scope)
    add_period_condition(scope)
  end

  private

  def add_period_condition(scope)
    if filter.period_start.present?
      scope = scope.where('users.created_at > ?', filter.period_start)
    end
    if filter.period_end.present?
      scope = scope.where('users.created_at < ?', filter.period_end)
    end
    scope
  end

  def add_keywords_condition(scope)
    if filter.keywords.present?
      keyword = filter.keywords.strip
      search_condition = 'name ILIKE :keyword OR email ILIKE :keyword'
      search_params = {keyword: "%#{keyword}%"}
      if filter.keywords.scan(/\d/).size >= 6
        search_condition += ' or users.phone ILIKE :phone'
        search_params[:phone] = "%#{filter.keywords.scan(/\d/).join.gsub(/^(380|7|8)/, '%')}%"
      end
      scope = scope.where(search_condition, search_params)
    end
    scope
  end

  def base_scope
    User.all.distinct
  end
end
