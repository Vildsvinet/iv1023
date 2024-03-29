/*Inlupp 4.6*/
SELECT title,
       originallanguage,
       genre,
       antalSpråk + 1         as "Antal Språk",
       calculateAuthorAmount  as "Antal författare",
       calculateEditionAmount as "Antal upplagor",
       years                  as "Året den tidigaste upplagen kom"
FROM (SELECT edition.book               as språkboktrack,
             COUNT(DISTINCT språk)      as antalSpråk,
             MIN(year)                  as years,
             COUNT(DISTINCT edition.id) as calculateEditionAmount
      FROM edition
               left outer join
           XMLTABLE('$t//Translation'
                    PASSING translations AS "t"
                    COLUMNS Språk VARCHAR(30) PATH '@Language') as tt on 1 = 1
      GROUP BY edition.book),

     (SELECT count(author) as calculateAuthorAmount, book.id as språkboktrack2, title, genre, book.originallanguage
      FROM authorship,
           book
      WHERE authorship.book = book.id
      GROUP BY book.id, title, genre, originallanguage)
WHERE språkboktrack = språkboktrack2
ORDER BY title

/*
 TITLE                        	ORIGINALLANGUAGE 	GENRE           	Antal Språk 	Antal författare 	Antal upplagor 	Året den tidigaste upplagen kom
 ---------------------------- 	---------------- 	--------------- 	----------- 	---------------- 	-------------- 	-------------------------------
 Archeology in Egypt         	English         	Educational    	          7	               3	             3	                           1992
 Contact                     	English         	Science Fiction	          4	               1	             1	                           1988
 Database Systems in Practice	English         	Educational    	          1	               3	             2	                           2000
 Dödliga Data                	Swedish         	Thriller       	          1	               1	             1	                           1993
 Encore une fois             	French          	NULL           	          5	               1	             2	                           1997
 European History            	English         	Educational    	         13	               8	             1	                           1998
 Le chateau de mon pere      	French          	NULL           	          6	               1	             1	                           1964
 Midsommar i Lund            	Swedish         	Novel          	          2	               1	             1	                           1988
 Misty Nights                	English         	Thriller       	          4	               1	             1	                           1987
 Music Now and Before        	English         	Educational    	          4	               2	             3	                           1997
 Musical Instruments         	English         	Educational    	          8	               2	             2	                           1991
 Oceanography for Dummies    	English         	Educational    	          2	               1	             2	                           2004
 Oceans on Earth             	English         	Educational    	          7	               3	             4	                           1996
 The Beach House             	English         	Novel          	          1	               2	             1	                           2002
 The Fifth Star              	English         	Novel          	          2	               1	             1	                           2003
 The Fourth Star             	English         	Science Fiction	          2	               1	             1	                           2001
 Våren vid sjön              	Swedish         	Novel          	          1	               1	             2	                           1982
*/