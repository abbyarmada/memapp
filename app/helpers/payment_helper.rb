module PaymentHelper
  now = Time.now.utc
  def g_chart_mems(endmonth = now.month.to_s, endday = now.end_of_month.day.to_s)
    now = Time.now.utc
    years = 5
    types = []
    years.times do |y|
      yr_end = ((now.year - y).to_s + '.' + endmonth + '.' + endday).to_date
      types[y] = Payment.countpays_for_year(yr_end)
    end
    member_classes = member_classes(years, types)
    keys = Hash[*member_classes.collect { |v| [member_classes.index(v), v] }.flatten.uniq].sort
    color_code = %w(0000ff ff0000 008000 FFd700 FFa500)
    yr_end = (now.year.to_s + '.' + endmonth + '.' + endday).to_date
    chart = GoogleChart::LineChart.new('600x200', 'Membership Trends, Year To ' + yr_end.strftime('%B %d'), false)
    years.times do |x|
      chart.shape_marker :circle, color: color_code[x], data_set_index: x, data_point_index: -1, pixel_size: 10
      chart.data((now.year - x), keys.collect { |_k, v| types[x][v].nil? ? 0 : types[x][v] }, color_code[x])
    end
    chart.axis :y, range: [0, 100], font_size: 10, alignment: :center
    chart.axis :x, labels: member_classes, font_size: 10, alignment: :center
    chart.show_legend = true
    @line_graph = chart.to_url
  end

  def member_classes(years, types)
    Array.new(years) { |t| types[t].keys }.flatten.uniq.sort
  end
end
