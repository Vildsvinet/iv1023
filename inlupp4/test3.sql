SELECT testtest.Title, COUNT(testtest.Language)
FROM
    (SELECT edition.id AS editionid, book.title AS Title, x.Language AS Language
     FROM book, edition,
         XMLTABLE(
             '$q//Translation'
             PASSING translations AS "q"
             COLUMNS Language VARCHAR(15) PATH '@Language'
         ) AS x
     WHERE book.id=edition.book
     GROUP BY x.Language, Title, edition.id) as testtest
GROUP BY Title


--
/*SELECT t1.*, edition.book, edition.translations FROM

(SELECT edition.id AS editionid, edition.book as bookid, tt.language, tt.price, tt.publisher
FROM Edition, XMLTABLE('$t//Translation'
				PASSING translations AS "t"
				COLUMNS Language VARCHAR(15) PATH '@Language',
				Price INTEGER PATH '@Price',
				Publisher VARCHAR(30) PATH '@Publisher') AS tt) AS t1
RIGHT JOIN Edition ON t1.bookid = Edition.book*/