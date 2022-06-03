/*Inlupp 4.1
  Vilka böcker har flera utgåvor?
*/

/*Ny lösning*/
SELECT XMLELEMENT(NAME "Resultat", XMLAGG(books))
FROM (
         SELECT XMLELEMENT(
                        NAME "Bok",
                        XMLATTRIBUTES(newbook.title AS "Titel")
                    ) AS books
         FROM
             (SELECT DISTINCT book.title
              FROM book, edition
              WHERE book.id = edition.book
              GROUP BY book.title
              HAVING COUNT(edition.book) > 1) newbook
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

