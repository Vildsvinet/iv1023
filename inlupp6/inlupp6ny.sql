/*Inlupp 6.5
  Den senaste upplagan (edition) av boken "Encore une fois" har översatts till norska och
  kostar 200 kronor. Den är utgiven av förlaget KLC. Gör ändringen i databasen

  //Feedback: Använd inte FROM och förenkla villkoret så att varje tabell används en gång.

  //Kommentar: Vi kanske fortfarande använder Edition två gånger, men i så fall skulle vi
  behöva lite hjälp med hur vi kan göra i stället. I db2 och Oracle gjorde vi en workaround
  där vi använde typ ROWNUM 1 och FETCH FIRST ROW ONLY, men vi hittade ingen sådan i SQL Server.
*/

/*Förslag på ny lösning*/
UPDATE edition
SET translations.modify ('insert <Translation Language = "Norwegian" Publisher = "KLC" Price = "200"/> as last into (/Translations)[1]')
        WHERE edition.book = (
    SELECT book.id
    FROM edition ed, book
    WHERE ed.book = book.id AND book.title = 'Encore une fois'
    GROUP BY book.id
    HAVING MAX(ed.year) = edition.year
)

/*OUTPUT
<Translations>
  <Translation Language="English" Publisher="Pels And Jafs" Price="180" />
  <Translation Language="Russian" Price="140" />
  <Translation Language="Norwegian" Publisher="KLC" Price="200" />
</Translations>
*/


/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/
/*Inlupp 6.6
  Ta fram följande information om samtliga böcker: titel, originalspråk, genre, antal
upplagor, antal olika språk boken finns tillgänglig i, antal författare, och året då den
tidigaste upplagan kom. */

SELECT ttt.title,
       ttt.originallanguage,
       ttt.genre,
       antalSpråk         AS "Antal Språk",
       ca                 AS "Antal författare",
       countAntalEditions AS "Antal upplagor",
       minYears           AS "Året den tidigaste upplagen kom"
FROM (SELECT edition.book                                            AS språkboktrack,
             COUNT(DISTINCT x.value('@Language', 'VARCHAR(30)')) + 1 AS antalSpråk,
             MIN(year)                                               AS minYears
      FROM edition outer apply translations.nodes('//Translation') AS Translation(x)
      GROUP BY edition.book) AS ids,

     (SELECT COUNT(author)  AS ca,
             book.id        AS språkboktrack2,
             title,
             genre,
             book.originallanguage,
             COUNT(book.id) AS countAntalEditions
      FROM authorship,
           book
      WHERE authorship.book = book.id
      GROUP BY book.id, title, genre, originallanguage) AS ttt
WHERE språkboktrack = språkboktrack2
GROUP BY språkboktrack, ttt.title, ttt.genre, ca, ttt.originallanguage, countAntalEditions, antalSpråk, minYears



/*OUTPUT
title                                              originallanguage     genre                Antal Språk Antal författare Antal upplagor Året den tidigaste upplagen kom
-------------------------------------------------- -------------------- -------------------- ----------- ---------------- -------------- -------------------------------
Misty Nights                                       English              Thriller             4           1                1              1987
Archeology in Egypt                                English              Educational          7           3                3              1992
Database Systems in Practice                       English              Educational          1           3                3              2000
Contact                                            English              Science Fiction      4           1                1              1988
The Fourth Star                                    English              Science Fiction      3           1                1              2001
Våren vid sjön                                     Swedish              Novel                1           1                1              1982
Dödliga Data                                       Swedish              Thriller             1           1                1              1993
Music Now and Before                               English              Educational          5           2                2              1997
Midsommar i Lund                                   Swedish              Novel                2           1                1              1988
Encore une fois                                    French               NULL                 6           1                1              1997
European History                                   English              Educational          13          8                8              1998
Musical Instruments                                English              Educational          9           2                2              1991
Oceans on Earth                                    English              Educational          8           3                3              1996
The Beach House                                    English              Novel                1           2                2              2002
Le chateau de mon pere                             French               NULL                 6           1                1              1964
Oceanography for Dummies                           English              Educational          2           1                1              2004

  */

/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/

/*Inlupp 6.7
  Ta fram information om på vilka språk varje förlag har böcker!
  //Feedback: GROUP BY-klausulen verkar onödig. Tabellen Publisher borde inte behövas två gånger.
*/

/*Ny lösning*/
SELECT publisher.name AS "@namn", publisher.country AS "@land",
       (SELECT DISTINCT x.value('@Language', 'VARCHAR(20)')
        FROM edition CROSS APPLY translations.nodes('//Translation') AS Språk(x)
        WHERE x.value('@Publisher','VARCHAR(20)') = publisher.name
            FOR XML AUTO, ELEMENTS, TYPE)
FROM publisher
ORDER BY publisher.name
    FOR XML PATH ('Förlag'), ROOT('Resultat')

/*OUTPUT
  <Resultat>
  <Förlag namn="ABC International" land="Germany">
    <Språk>Russian</Språk>
    <Språk>Chinese</Språk>
    <Språk>French</Språk>
    <Språk>Dutch</Språk>
    <Språk>Spanish</Språk>
    <Språk>Portuguese</Språk>
    <Språk>German</Språk>
    <Språk>Danish</Språk>
    <Språk>Italian</Språk>
  </Förlag>
  <Förlag namn="Addison" land="France">
    <Språk>Russian</Språk>
    <Språk>French</Språk>
  </Förlag>
  <Förlag namn="Aurora Publ." land="Italy">
    <Språk>Italian</Språk>
  </Förlag>
  <Förlag namn="Bästa Bok" land="Sweden">
    <Språk>Swedish</Språk>
  </Förlag>
  <Förlag namn="Benton Inc" land="England">
    <Språk>English</Språk>
  </Förlag>
  <Förlag namn="EU Publishing" land="Belgium">
    <Språk>Swedish</Språk>
    <Språk>Greek</Språk>
    <Språk>Russian</Språk>
    <Språk>Norwegian</Språk>
    <Språk>French</Språk>
    <Språk>Finnish</Språk>
    <Språk>Dutch</Språk>
    <Språk>Spanish</Språk>
    <Språk>Portuguese</Språk>
    <Språk>Danish</Språk>
    <Språk>Italian</Språk>
    <Språk>Bulgarian</Språk>
  </Förlag>
  <Förlag namn="Kingsly" land="Austria">
    <Språk>German</Språk>
  </Förlag>
  <Förlag namn="KLC" land="Sweden">
    <Språk>Swedish</Språk>
    <Språk>Norwegian</Språk>
    <Språk>French</Språk>
    <Språk>Italian</Språk>
    <Språk>gurka</Språk>
  </Förlag>
  <Förlag namn="Pels And Jafs" land="Scotland">
    <Språk>English</Språk>
  </Förlag>
  <Förlag namn="RP" land="Russia">
    <Språk>Russian</Språk>
  </Förlag>
  <Förlag namn="SCB" land="Sweden">
    <Språk>Swedish</Språk>
  </Förlag>
  <Förlag namn="Shou-Ling" land="China">
    <Språk>Chinese</Språk>
  </Förlag>
  <Förlag namn="Suomi Bookkii" land="Finland">
    <Språk>Finnish</Språk>
  </Förlag>
  <Förlag namn="Turk And Turk" land="Turkey">
    <Språk>Turkish</Språk>
  </Förlag>
</Resultat>
  */