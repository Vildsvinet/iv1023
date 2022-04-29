SELECT XMLELEMENT(NAME "Resultat", XMLAGG(books))
FROM (
         SELECT XMLELEMENT(
                    NAME "Bok",
                    XMLATTRIBUTES(book.title AS "Titel")
                ) AS books
         FROM book, edition
         WHERE book.id = edition.book
           AND (
                   SELECT COUNT(edition.id)
                   FROM edition
                   WHERE book.ID = edition.book
               ) > 1
         GROUP BY book.title
     )
