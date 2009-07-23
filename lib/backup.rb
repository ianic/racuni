require 'date'
d = Date.today
system "mysqldump -uroot nektar > c:/backup/nektar_#{d.to_s}.dump"