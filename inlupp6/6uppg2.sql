/*Inlupp 6.2
  Vilka böckers översättningar har publicerats av varje förlag?
  //TODO Det hade varit enklare att behålla kolumnen name istället för att använda metoden value på kolumnen x.
*/

SELECT DISTINCT Förlag AS Namn, Land, title AS Titel, genre AS Genre
FROM (SELECT publisher.country AS Land, edition.book, x.value('@Publisher', 'VARCHAR(30)') AS Förlag
      FROM publisher,
           edition
               CROSS APPLY translations.nodes('//Translation') AS Translation(x)
      WHERE publisher.name = x.value('@Publisher', 'VARCHAR(30)')) AS Förlag,
     book AS Bok
WHERE Bok.id = book
--GROUP BY title, Förlag, Genre, Land       -ersatt med DISTINCT, samma output
ORDER BY Förlag
FOR XML AUTO, ROOT('Resultat')

/*OUTPUT
<Resultat>
  <Förlag Namn="ABC International" Land="Germany">
    <Bok Titel="Archeology in Egypt" Genre="Educational" />
    <Bok Titel="Music Now and Before" Genre="Educational" />
    <Bok Titel="Musical Instruments" Genre="Educational" />
    <Bok Titel="Oceanography for Dummies" Genre="Educational" />
    <Bok Titel="Oceans on Earth" Genre="Educational" />
  </Förlag>
  <Förlag Namn="Addison" Land="France">
    <Bok Titel="Misty Nights" Genre="Thriller" />
  </Förlag>
  <Förlag Namn="Aurora Publ." Land="Italy">
    <Bok Titel="Le chateau de mon pere" />
  </Förlag>
  <Förlag Namn="Bästa Bok" Land="Sweden">
    <Bok Titel="The Fourth Star" Genre="Science Fiction" />
  </Förlag>
  <Förlag Namn="Benton Inc" Land="England">
    <Bok Titel="Le chateau de mon pere" />
  </Förlag>
  <Förlag Namn="EU Publishing" Land="Belgium">
    <Bok Titel="European History" Genre="Educational" />
  </Förlag>
  <Förlag Namn="Kingsly" Land="Austria">
    <Bok Titel="Misty Nights" Genre="Thriller" />
  </Förlag>
  <Förlag Namn="KLC" Land="Sweden">
    <Bok Titel="Archeology in Egypt" Genre="Educational" />
    <Bok Titel="Encore une fois" />
  </Förlag>
  <Förlag Namn="Pels And Jafs" Land="Scotland">
    <Bok Titel="Encore une fois" />
  </Förlag>
  <Förlag Namn="RP" Land="Russia">
    <Bok Titel="Contact" Genre="Science Fiction" />
  </Förlag>
  <Förlag Namn="SCB" Land="Sweden">
    <Bok Titel="Contact" Genre="Science Fiction" />
  </Förlag>
  <Förlag Namn="Shou-Ling" Land="China">
    <Bok Titel="Archeology in Egypt" Genre="Educational" />
  </Förlag>
  <Förlag Namn="Suomi Bookkii" Land="Finland">
    <Bok Titel="Midsommar i Lund" Genre="Novel" />
  </Förlag>
  <Förlag Namn="Turk And Turk" Land="Turkey">
    <Bok Titel="Archeology in Egypt" Genre="Educational" />
  </Förlag>
</Resultat>
*/