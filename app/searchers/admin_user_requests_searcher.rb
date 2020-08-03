class AdminUserRequestsSearcher
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
      scope = scope.where('created_at > ?', filter.period_start)
    end
    if filter.period_end.present?
      scope = scope.where('created_at < ?', filter.period_end)
    end
    scope
  end

  def add_keywords_condition(scope)
    if filter.keywords.present?
      phone = filter.keywords.scan(/\d/).join.gsub(/^(7|8)/, '%')
      scope = scope.where("phone ILIKE ?", "%#{phone}%")
    end
    scope
  end

  def base_scope
    UserRequest.all
  end
end
