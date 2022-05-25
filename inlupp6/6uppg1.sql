SELECT Book.title AS Titel
FROM Book, Edition
WHERE book.id=edition.book
GROUP BY book.title
HAVING COUNT(edition.book) > 1
ORDER BY Book.title
FOR XML RAW ('Bok'), ROOT('Resultat')

/*OUTPUT
<Resultat>
  <Bok Titel="Archeology in Egypt" />
  <Bok Titel="Database Systems in Practice" />
  <Bok Titel="Encore une fois" />
  <Bok Titel="Music Now and Before" />
  <Bok Titel="Musical Instruments" />
  <Bok Titel="Oceanography for Dummies" />
  <Bok Titel="Oceans on Earth" />
  <Bok Titel="Våren vid sjön" />
</Resultat>
*/