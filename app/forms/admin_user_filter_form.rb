class AdminUserFilterForm < BaseForm
  attr_accessor :period_start, :period_end, :keywords

  def period_end= val
    @period_end = Time.zone.parse(val).end_of_day rescue nil
  end

  def period_start= val
    @period_start = Time.zone.parse(val).beginning_of_day rescue nil
  end
end
