echo Migrations...
call rake db:schema:load
rem call rake db:migrate version=0
rem call rake db:migrate  

del *.csv
del ..\test\fixtures\*.csv

echo Exporting...
call ruby %1.rb

echo Converting to UTF8...
call iconv -f cp1250 -t utf-8 partner.csv 			> ..\test\fixtures\partner.csv
call iconv -f cp1250 -t utf-8 stavka.csv 			> ..\test\fixtures\stavka.csv
call iconv -f cp1250 -t utf-8 racun.csv 			> ..\test\fixtures\racun.csv
call iconv -f cp1250 -t utf-8 ulazni_racun.csv 		> ..\test\fixtures\ulazni_racun.csv
call iconv -f cp1250 -t utf-8 gotovinski_racun.csv 	> ..\test\fixtures\gotovinski_racun.csv
call iconv -f cp1250 -t utf-8 ponuda.csv 			> ..\test\fixtures\ponuda.csv
call iconv -f cp1250 -t utf-8 racun_placanje.csv 	> ..\test\fixtures\racun_placanje.csv
call iconv -f cp1250 -t utf-8 racun_stavka.csv 		> ..\test\fixtures\racun_stavka.csv
call iconv -f cp1250 -t utf-8 izdatak.csv 			> ..\test\fixtures\izdatak.csv

echo Importing...
call mysqlimport -uroot --ignore-lines=1 --fields-terminated-by=, --lines-terminated-by=\r\n --fields-enclosed-by=""" --default-character-set=utf8 --columns=id,godina,broj,partner_id,datum,rok_placanja,popust_postotak,pdv_postotak,osnovica,popust,pdv,iznos,napomena %1 c:/projects/racuni/trunk/lib\..\test\fixtures\gotovinski_racun.csv
call mysqlimport -uroot --ignore-lines=1 --fields-terminated-by=, --lines-terminated-by=\r\n --fields-enclosed-by=""" --default-character-set=utf8 --columns=id,type,partner_id,godina,broj,datum,opis,tip_uplate,iznos,pdv %1 c:/projects/racuni/trunk/lib\..\test\fixtures\izdatak.csv
call mysqlimport -uroot --ignore-lines=1 --fields-terminated-by=, --lines-terminated-by=\r\n --fields-enclosed-by=""" --default-character-set=utf8 --columns=id,naziv,mjesto,adresa,tel,fax,porezni_broj,ziro_racun,kontakt %1 c:/projects/racuni/trunk/lib\..\test\fixtures\partner.csv
call mysqlimport -uroot --ignore-lines=1 --fields-terminated-by=, --lines-terminated-by=\r\n --fields-enclosed-by=""" --default-character-set=utf8 --columns=id,godina,broj,partner_id,datum,rok_placanja,popust_postotak,pdv_postotak,osnovica,popust,pdv,iznos,napomena %1 c:/projects/racuni/trunk/lib\..\test\fixtures\ponuda.csv
call mysqlimport -uroot --ignore-lines=1 --fields-terminated-by=, --lines-terminated-by=\r\n --fields-enclosed-by=""" --default-character-set=utf8 --columns=id,godina,broj,partner_id,datum,rok_placanja,popust_postotak,pdv_postotak,osnovica,popust,pdv,iznos,placen,placeno,napomena %1 c:/projects/racuni/trunk/lib\..\test\fixtures\racun.csv
call mysqlimport -uroot --ignore-lines=1 --fields-terminated-by=, --lines-terminated-by=\r\n --fields-enclosed-by=""" --default-character-set=utf8 --columns=racun_id,racun_type,iznos,dokument,datum %1 c:/projects/racuni/trunk/lib\..\test\fixtures\racun_placanje.csv
call mysqlimport -uroot --ignore-lines=1 --fields-terminated-by=, --lines-terminated-by=\r\n --fields-enclosed-by=""" --default-character-set=utf8 --columns=racun_id,racun_type,stavka_id,kolicina,cijena %1 c:/projects/racuni/trunk/lib\..\test\fixtures\racun_stavka.csv
call mysqlimport -uroot --ignore-lines=1 --fields-terminated-by=, --lines-terminated-by=\r\n --fields-enclosed-by=""" --default-character-set=utf8 --columns=id,opis,jedinica_mjere,cijena %1 c:/projects/racuni/trunk/lib\..\test\fixtures\stavka.csv
call mysqlimport -uroot --ignore-lines=1 --fields-terminated-by=, --lines-terminated-by=\r\n --fields-enclosed-by=""" --default-character-set=utf8 --columns=id,godina,broj,partner_id,partner_broj,datum,rok_placanja,popust_postotak,pdv_postotak,osnovica,popust,pdv,iznos,placen,placeno,napomena,tip_predporeza,tip_placanja %1 c:/projects/racuni/trunk/lib\..\test\fixtures\ulazni_racun.csv

rem cd ..
rem ruby c:/ruby/bin/rake  load_fixtures --trace
rem cd lib