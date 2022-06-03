/*Inlupp 4.1
  Vilka böcker har flera utgåvor?
  //Feedback:
  //-Varför använder ni tabellen edtition två gånger?
  //-Vad är syftet med GROUP BY?
*/

/*Förslag på ny lösning. Ingen tabell används mer än en gång.
  Syftet med GROUP BY är att kunna räkna hur många utgåvor som finns för varje boktitel*/
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

