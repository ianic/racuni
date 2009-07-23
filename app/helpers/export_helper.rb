module ExportHelper

  def export_header
    headers['Content-Type'] = "application/vnd.ms-excel" 
    headers['Content-Disposition'] = "attachment; filename=\"#{@title}.xls\""
    headers['Cache-Control'] = ''
  end
  
  def export_excel_xml(template)
    export_header
    render :template => template, :layout => 'nil'
  end
  
  def export_table(titles, data) 
    export_header  
    render(:partial => "export/table", 
      :locals => {'sheet_name' => @title, 'titles' => titles, 'data' => data})
  end
  
  def csv?
    return @format == "csv"
  end

 #require 'csv'  
#  def render_csv(template)
#    response.headers['Content-Type'] = 'text/csv; charset=UTF-8; header=present'
#    response.headers['Content-Disposition'] = "attachment; filename=export.csv"
#    render :template => template , :layout => "nil"
#  end
  
end