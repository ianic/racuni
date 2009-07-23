Dir.entries(".").each do |f| 
	if f[-3..-1] == "csv" 
		fp = File.open(f)
		columns = fp.readline[0..-2].gsub(" ", "")
		fp.close
		#p columns
		#p "#{Dir.getwd + '..\\test\\fixtures\\' + f}"
		print "call mysqlimport -uroot --ignore-lines=1 --fields-terminated-by=, --lines-terminated-by=\\r\\n --fields-enclosed-by=\"\"\" --default-character-set=utf8 --columns=#{columns} %1 #{Dir.getwd + '\\..\\test\\fixtures\\' + f}\n"
	end
end
