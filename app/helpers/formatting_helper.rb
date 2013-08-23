# -*- coding: iso-8859-2 -*-
module FormattingHelper

  def date_select_hr(object, method)
    date_select(object, method, :order=> [:day, :month, :year], :use_month_numbers=>true)
  end

  def select_date_hr(date)
    options = {:use_month_numbers=>true}
    select_day(date, options) + select_month(date, options) + select_year(date, options)
  end

  def to_short_date(date)
    date.strftime("%d.%m.%Y") if date
  end

  #short date format
  def d(date)
    date.to_s(:hr) if date
  end

  #money format
  def m(number)
    to_money(number)
  end

  #format količina
  def k(number, precision = -1)
    (return to_money(number, 0)) if number.to_i == number
    if precision == -1
      parts = number.to_s.split('.')
      parts[1] = parts[1] ? ',' + parts[1] : ''
      return number_with_delimiter(parts[0], '.') +  parts[1]
    else
      to_money(number, precision)
    end
  rescue
    number
  end

  def to_money(number, precision = 2)
    number_to_currency(number, {:unit => "", :separator => ",", :delimiter => ".", :precision => precision})
  end

end
