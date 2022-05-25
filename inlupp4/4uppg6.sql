/*Inlupp 4.6
  Ta fram följande information om samtliga böcker: titel, originalspråk, genre, antal
  upplagor, antal olika språk boken finns tillgänglig på, antal författare och året då den
  tidigaste upplagan kom.
*/

SELECT Title, OriginalLanguage, Genre, COUNT(Edition.book) AS NrOfEditions, languagetable.NrOfLanguages, authortable.NrOfAuthors, MIN(Edition.year) AS FirstEdition
FROM Book, Edition,
     (
         SELECT Book.id AS authorid, COUNT(Authorship.author) AS NrOfAuthors
         FROM Book, Authorship
         WHERE Book.id = Authorship.book
         GROUP BY Book.id
     ) AS authortable
        ,
     (
         SELECT edition.book as languageid, count(distinct (t1.language))+1 as NrOfLanguages
         FROM
             (SELECT edition.id AS editionid, edition.book as bookid, tt.language
              FROM Edition,
                   XMLTABLE('$t//Translation'
                        PASSING translations AS "t"
				        COLUMNS Language VARCHAR(15) PATH '@Language') AS tt) AS t1
                 RIGHT JOIN Edition ON t1.bookid = Edition.book
         GROUP BY edition.book
     ) AS languagetable
WHERE Book.id = Edition.book
  AND authortable.authorid = Book.id
  AND languagetable.languageid = Book.id
GROUP BY Title, OriginalLanguage, Genre, NrOfAuthors, NrOfLanguages
ORDER BY Title

/*OUTPUT
 TITLE                        ORIGINALLANGUAGE GENRE           NROFEDITIONS NROFLANGUAGES NROFAUTHORS FIRSTEDITION
 ---------------------------- ---------------- --------------- ------------ ------------- ----------- ------------
 Archeology in Egypt          English          Educational                3             7           3         1992
 Contact                      English          Science Fiction            1             4           1         1988
 Database Systems in Practice English          Educational                2             1           3         2000
 Dödliga Data                 Swedish          Thriller                   1             1           1         1993
 Encore une fois              French           NULL                       2             4           1         1997
 European History             English          Educational                1            13           8         1998
 Le chateau de mon pere       French           NULL                       1             6           1         1964
 Midsommar i Lund             Swedish          Novel                      1             2           1         1988
 Misty Nights                 English          Thriller                   1             4           1         1987
 Music Now and Before         English          Educational                3             4           2         1997
 Musical Instruments          English          Educational                2             8           2         1991
 Oceanography for Dummies     English          Educational                2             2           1         2004
 Oceans on Earth              English          Educational                4             7           3         1996
 The Beach House              English          Novel                      1             1           2         2002
 The Fifth Star               English          Novel                      1             2           1         2003
 The Fourth Star              English          Science Fiction            1             2           1         2001
 Våren vid sjön               Swedish          Novel                      2             1           1         1982
*/