/*Inlupp 6.6
  Ta fram följande information om samtliga böcker: titel, originalspråk, genre, antal
  upplagor, antal olika språk boken finns tillgänglig på, antal författare och året då den
  tidigaste upplagan kom.
  //Feedback:
  //Förenkla lösningen så att tabellen book endast används en gång.
  //Använd inte tabellen book så många gånger. Joina inte med titeln.
  //Använd primärnyckel och främmande nyckeln. Delen som tar fram antal språk kan plattas till och förenklas.
*/

/*Ny lösning*/
SELECT ttt.title,  ttt.originallanguage, ttt.genre, ISNULL(antalSpråk, 0) +1 AS "Antal Språk" ,
       ca AS "Antal författare", ce AS "Antal upplagor", MIN(year) AS "Året den tidigaste upplagen kom"
FROM
    (SELECT edition.book AS språkboktrack, count(edition.book) AS antalSpråk
     FROM edition cross apply translations.nodes('//Translation') AS Translation(x)
     GROUP BY edition.book) AS ids full outer join edition ON edition.book = språkboktrack,

    (SELECT count(author) AS ca, book.id AS språkboktrack2, title, genre, book.originallanguage, count(book.id) AS ce
     FROM authorship, book
     WHERE authorship.book = book.id
     GROUP BY book.id, title, genre, originallanguage) AS ttt
WHERE edition.book = språkboktrack2
GROUP BY språkboktrack, antalSpråk, ttt.title, ttt.genre, ca, ttt.originallanguage, ce

/*OUTPUT
Title                                              OriginalLanguage     Genre                NrOfEditions NrOfLanguages NrOfAuthors FirstEdition
-------------------------------------------------- -------------------- -------------------- ------------ ------------- ----------- ------------
Archeology in Egypt                                English              Educational          3            7             3           1992
Contact                                            English              Science Fiction      1            4             1           1988
Database Systems in Practice                       English              Educational          2            1             3           2000
Dödliga Data                                       Swedish              Thriller             1            1             1           1993
Encore une fois                                    French               NULL                 2            3             1           1997
European History                                   English              Educational          1            13            8           1998
Le chateau de mon pere                             French               NULL                 1            6             1           1964
Midsommar i Lund                                   Swedish              Novel                1            2             1           1988
Misty Nights                                       English              Thriller             1            4             1           1987
Music Now and Before                               English              Educational          3            4             2           1997
Musical Instruments                                English              Educational          2            8             2           1991
Oceanography for Dummies                           English              Educational          2            2             1           2004
Oceans on Earth                                    English              Educational          4            7             3           1996
The Beach House                                    English              Novel                1            1             2           2002
The Fourth Star                                    English              Science Fiction      1            2             1           2001
Våren vid sjön                                     Swedish              Novel                2            1             1           1982
*/


/*OLD SOLUTION*/
-- SELECT book.Title,
--        OriginalLanguage,
--        Genre,
--        COUNT(Edition.book) AS NrOfEditions,
--        languagetable.NrOfLanguages,
--        authortable.NrOfAuthors,
--        MIN(Edition.year)   AS FirstEdition
-- FROM Book,
--      Edition,
--      (SELECT Book.id AS bookidfromauthortable, COUNT(Authorship.author) AS NrOfAuthors
--       FROM Book,
--            Authorship
--       WHERE Book.id = Authorship.book
--       GROUP BY Book.id) AS authortable,
--
--      (SELECT t2.title, COUNT(distinct (språk)) + 1 AS NrOfLanguages
--       FROM (SELECT t1.title, t1.språk
--             FROM (SELECT title,
--                          book.id,
--                          x.value('@Language', 'VARCHAR(20)')  AS språk
--                   FROM edition CROSS APPLY translations.nodes('//Translation') AS Translation(x)
--                                RIGHT JOIN book
--                                           ON book.id=edition.book) AS t1) t2
--       GROUP BY title) languagetable
--
-- WHERE Book.id = Edition.book
--   AND authortable.bookidfromauthortable = Book.id
--   AND languagetable.title = Book.title
-- GROUP BY book.title, OriginalLanguage, Genre, NrOfAuthors, NrOfLanguages
-- ORDER BY book.title