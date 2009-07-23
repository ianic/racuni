class FindConditionsHelper
  
  def initialize(field_prefix  = nil)
    @args = Array.new
    @field_prefix = field_prefix  ? "#{field_prefix }.": ""
  end
  
  def <<(sql)
    @args << sql
  end
   
  def int(column_name, value)
    return if value == 0
    int2(column_name, value)
  end
  
  def int2(column_name, value)
    @args << "#{@field_prefix}#{column_name} = #{value}" 
  end
  
  def placanje=(value)         
    return if !value
    @args <<  "#{@field_prefix}placen = 0 and (#{@field_prefix}datum + interval #{@field_prefix}rok_placanja day) < CURDATE()"  if value == 1
    @args <<  "#{@field_prefix}placen = 0"  if value == 2
    @args <<  "#{@field_prefix}placen = 1"  if value == 3
  end
  
  def tip_placanja=(value)  
    return if value < 0
    int2("tip_placanja", value)
  end
  
  def mjesec=(value)
    return if !value || value.empty? || value == "..."
    @args << "month(#{@field_prefix}datum) in (#{value})" 
  end
  
  def godina=(value)
    return if !value
    @args << "year(#{@field_prefix}datum) = #{value}" 
  end
  
  def like(column_name, value)
    return if value.to_s.empty?
    @args << "#{@field_prefix}#{column_name} like  '%#{value}%'"
  end
  
  def where
    @args.join(" and ") if !@args.empty?
  end
  
  def iznos(eq, from, to)
    if eq
     @args << "#{@field_prefix}iznos between #{eq - 0.99} and #{eq + 0.99}"
     return
    end
    return if !from && !to 
    if !to
      @args << "#{@field_prefix}iznos > #{from}" 
    elsif !from
      @args << "#{@field_prefix}iznos < #{to}"
    else
      @args << "#{@field_prefix}iznos between #{from} and #{to}" 
    end
  end
  
end