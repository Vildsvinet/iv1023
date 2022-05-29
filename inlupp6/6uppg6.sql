/*Inlupp 6.6
  Ta fram följande information om samtliga böcker: titel, originalspråk, genre, antal
  upplagor, antal olika språk boken finns tillgänglig på, antal författare och året då den
  tidigaste upplagan kom.
*/

SELECT book.Title,
       OriginalLanguage,
       Genre,
       COUNT(Edition.book) AS NrOfEditions,
       languagetable.NrOfLanguages,
       authortable.NrOfAuthors,
       MIN(Edition.year)   AS FirstEdition
FROM Book,
     Edition,
     (SELECT Book.id AS authorid, COUNT(Authorship.author) AS NrOfAuthors
      FROM Book,
           Authorship
      WHERE Book.id = Authorship.book
      GROUP BY Book.id) AS authortable,

     (SELECT t2.title, COUNT(distinct (språk)) + 1 AS NrOfLanguages
      FROM (SELECT t1.title, t1.språk
            FROM (SELECT title,
                         book.id,
                         x.value('@Language', 'VARCHAR(20)')  AS språk
                  FROM edition CROSS APPLY translations.nodes('//Translation') AS Translation(x)
				RIGHT JOIN book
                  ON book.id=edition.book) AS t1) t2
      GROUP BY title) languagetable

WHERE Book.id = Edition.book
  AND authortable.authorid = Book.id
  AND languagetable.title = Book.title
GROUP BY book.title, OriginalLanguage, Genre, NrOfAuthors, NrOfLanguages
ORDER BY book.title

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