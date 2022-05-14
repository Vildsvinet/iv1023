--Ta fram namn och land på författare till böcker som har översatts till ryska! Resultatet skall ha två kolumner

SELECT Author.name, ll.land
FROM Edition, Book, Author, Authorship,
    XMLTABLE(
        '$t//Translation[@Language="Russian"]'
        PASSING Translations AS "t"
        COLUMNS Språk VARCHAR(30) PATH '@Language'
    ) AS tt,
    XMLTABLE(
        '$a//Info'
        PASSING Info AS "a"
        COLUMNS Land VARCHAR(30) PATH 'Country'
    ) AS ll
WHERE tt.Språk = 'Russian' AND book.id = edition.book
  AND book.id = authorship.book AND author.id = authorship.author
GROUP BY Author.name, ll.land


/*
    NAME                	LAND
 ------------------- 	--------
 Andreas Shultz     	Austria
 Alicia Bing        	Belgium
 Pierre Zargone     	Belgium
 John Craft         	England
 Peter Feldon       	England
 Carl George        	France
 Antje Liedderman   	Germany
 Kostas Andrianos   	Greece
 Sam Davis          	Mexiko
 Christina Ohlsen   	Norway
 Auna Gonzales Perre	Portugal
 Lilian Carrera     	Spain
 Carl Sagan         	USA
 Linda Evans        	USA
 Mimi Pappas        	USA
*/