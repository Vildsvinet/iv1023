/*Inlupp 4.1
  Vilka böcker har flera utgåvor?
*/

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

/*Output
  <Resultat>
    <Bok Titel="Archeology in Egypt"/>
    <Bok Titel="Database Systems in Practice"/>
    <Bok Titel="Encore une fois"/>
    <Bok Titel="Music Now and Before"/>
    <Bok Titel="Musical Instruments"/>
    <Bok Titel="Oceanography for Dummies"/>
    <Bok Titel="Oceans on Earth"/>
    <Bok Titel="Våren vid sjön"/>
  </Resultat>
*/


/*
ALTERNATIVE SOLUTION

SELECT XMLELEMENT(NAME "Resultat", XMLAGG(books))
FROM (
         SELECT XMLELEMENT(
                        NAME "Bok",
                        XMLATTRIBUTES(book.title AS "Titel")
                    ) AS books
         FROM book, edition
         WHERE book.id = edition.book
--            AND (
--                    SELECT COUNT(edition.id)
--                    FROM edition
--                    WHERE book.ID = edition.book
--                ) > 1
         GROUP BY book.title
         HAVING COUNT(edition.id)>1
     )
*/