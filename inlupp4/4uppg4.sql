/*Inlupp 4.4
  Ta fram namn och land på författare till böcker som har översatts till ryska! Resultatet skall ha två kolumner
*/

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
ORDER BY Author.name

/*
 NAME                LAND
 ------------------- --------
 Alicia Bing         Belgium
 Andreas Shultz      Austria
 Antje Liedderman    Germany
 Auna Gonzales Perre Portugal
 Carl George         France
 Carl Sagan          USA
 Christina Ohlsen    Norway
 John Craft          England
 Kostas Andrianos    Greece
 Lilian Carrera      Spain
 Linda Evans         USA
 Mimi Pappas         USA
 Peter Feldon        England
 Pierre Zargone      Belgium
 Sam Davis           Mexiko
*/