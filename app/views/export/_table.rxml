# sheet_name
# titles
# data

xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8" 
xml.Workbook({
  'xmlns'      => "urn:schemas-microsoft-com:office:spreadsheet", 
  'xmlns:o'    => "urn:schemas-microsoft-com:office:office",
  'xmlns:x'    => "urn:schemas-microsoft-com:office:excel",    
  'xmlns:html' => "http://www.w3.org/TR/REC-html40",
  'xmlns:ss'   => "urn:schemas-microsoft-com:office:spreadsheet" 
  }) do

  xml.Styles do
   xml.Style 'ss:ID' => 'Default', 'ss:Name' => 'Normal' do
     xml.Alignment 'ss:Vertical' => 'Bottom'
     xml.Borders
     xml.Font 'x:CharSet'=>"238", 'x:Family'=>"Swiss", 'ss:Size'=>"8"
     xml.Interior
     xml.NumberFormat
     xml.Protection
   end
   xml.Style 'ss:ID' => 's16', 'ss:Name' => "Comma" do
     xml.NumberFormat 'ss:Format' => '_-* #,##0.00 _k_n_-;-* #,##0.00 _k_n_-;_-* "-"?? _k_n_-;_-@_-'    
   end
   xml.Style 'ss:ID' => 's22' do
     xml.NumberFormat 'ss:Format' => 'd/m/yy/;@'    
   end
  end

  xml.Worksheet 'ss:Name' => sheet_name do
    xml.Table do

      # Header
      xml.Row do
        for title in titles do
          xml.Cell do
            xml.Data title, 'ss:Type' => 'String'
          end
        end
      end

      # Rows
      for row in data
        xml.Row do		  	 
          for value in row do
			type = 'String'
			cell_args = {}
			if value.class == BigDecimal
				type = 'Number' 
				cell_args = {'ss:StyleID' => 's16'}
			end
			if value.class == Fixnum
				type = 'Number' 
			end
			if value.class == Date
				type = 'DateTime'
				cell_args = {'ss:StyleID' => 's22'}
			end			
            xml.Cell cell_args do			  
			  xml.Data value, 'ss:Type' => type
            end
          end
        end
      end

    end
  end

end