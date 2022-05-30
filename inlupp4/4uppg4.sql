/*Inlupp 4.4
  Ta fram namn och land på författare till böcker som har översatts till ryska! Resultatet skall ha två kolumner

  Feedback
  -Tabellen Book verkar onödig.
    Svar: Vi behövde joina tabellerna edition och authorship och på den grafiska representationen
    av relationsdatabasen så ligger tabellen Book "mitt emellan" och vi ville använda nycklar.
  -Varför använder ni GROUP BY? ta bort dubbletterna kan ni göra med DISTINCT
    Svar: ok, ändrat!
  -Eventuellt hade en lösning med XMLEXISTS varit kompaktare.
    Svar: ok, ändrat!
  -Språket är endast relevant som en del av villkoret. Just nu verkar ni jämföra att 'Russian' är 'Russian'
    Svar: Hoppsan!
*/

--NEW SOLUTION:
SELECT DISTINCT Author.name, it.land
FROM Author, Authorship,
     (SELECT book
      FROM edition
      WHERE XMLEXISTS('$t//Translation[@Language="Russian"]' PASSING Translations AS "t")
      ) AS ed,
     XMLTABLE(
             '$a//Info'
             PASSING Info AS "a"
             COLUMNS Land VARCHAR(30) PATH 'Country'
     ) AS it
WHERE ed.book = authorship.book AND author.id = authorship.author
ORDER BY Author.name

/*OUTPUT:
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

/*OLD SOLUTION
SELECT DISTINCT Author.name, it.land
FROM Edition, Author, Authorship,
     XMLTABLE(
             '$t//Translation[@Language="Russian"]'
             PASSING Translations AS "t"
             COLUMNS Språk VARCHAR(30) PATH '@Language'
         ) AS tt,
     XMLTABLE(
             '$a//Info'
             PASSING Info AS "a"
             COLUMNS Land VARCHAR(30) PATH 'Country'
         ) AS it
WHERE edition.book = authorship.book AND author.id = authorship.author
ORDER BY Author.name
 */