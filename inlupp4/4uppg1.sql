/*Inlupp 4.1
  Vilka böcker har flera utgåvor?
  //TODO Varför använder ni tabellen edtition två gånger?
  //TODO Vad är syftet med GROUP BY?
*/

/*New suggestion.
  We have removed the extra SELECT clause by introducing a "HAVING" clause after the "GROUP BY".
  The purpose of the GROUP BY is to get rid of duplicates. SELECT DISTINCT won't work since
  we are operating on XML values. But please explain if there is a better solution!
  */
SELECT XMLELEMENT(NAME "Resultat", XMLAGG(books))
FROM (
         SELECT XMLELEMENT(
                        NAME "Bok",
                        XMLATTRIBUTES(book.title AS "Titel")
                    ) AS books
         FROM book, edition
         WHERE book.id = edition.book
         GROUP BY book.title
         HAVING COUNT(edition.book) > 1
     )

--Old solution
-- SELECT XMLELEMENT(NAME "Resultat", XMLAGG(books))
-- FROM (
--          SELECT XMLELEMENT(
--                     NAME "Bok",
--                     XMLATTRIBUTES(book.title AS "Titel")
--                 ) AS books
--          FROM book, edition
--          WHERE book.id = edition.book
--            AND (
--                    SELECT COUNT(edition.id)
--                    FROM edition
--                    WHERE book.ID = edition.book
--                ) > 1
--          GROUP BY book.title
--      )

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