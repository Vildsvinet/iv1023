--Ta fram följande information om samtliga böcker: titel, originalspråk, genre, antal
--upplagor, antal olika språk boken finns tillgänglig på, antal författare och året då den
--tidigaste upplagan kom.
--

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