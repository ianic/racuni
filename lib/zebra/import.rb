tables = %w(partner stavka racun racun_stavka racun_placanje ulazni_racun ulazni_racun_placanje izdatak primitak)

File.rename("c:/work/racuni/zebra/racun_st.csv", "c:/work/racuni/zebra/racun_stavka.csv")
File.rename("c:/work/racuni/zebra/racun_pl.csv", "c:/work/racuni/zebra/racun_placanje.csv")
File.rename("c:/work/racuni/zebra/ulazni_r.csv", "c:/work/racuni/zebra/ulazni_racun.csv")
File.rename("c:/work/racuni/zebra/ulazni_p.csv", "c:/work/racuni/zebra/ulazni_racun_placanje.csv")

tables.each do |table|  
  print "\n--------Importing table #{table}\n"
    
  system  "iconv -f cp1250 -t utf-8 c:/work/racuni/zebra/#{table}.csv > c:/work/racuni/trunk/lib/zebra/#{table}.csv" 
  #system 'mysqlimport -uroot                                        --ignore-lines=1 --delete --fields-optionally-enclosed-by=\" --fields-terminated-by=; --lines-terminated-by=\r\n --default-character-set=utf8 zebra ' + "c:/work/racuni/trunk/lib/zebra/#{table}.csv"
  
  system 'mysqlimport -v -L -hzebra.igoranic.com -P33306 -uianic -pdsalkjmn --ignore-lines=1 --delete --fields-optionally-enclosed-by=\" --fields-terminated-by=; --lines-terminated-by=\r\n --default-character-set=utf8 racuni ' + "c:/work/racuni/trunk/lib/zebra/#{table}.csv"
  
end
