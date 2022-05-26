/*Inlupp 6.2
  Vilka böckers översättningar har publicerats av varje förlag?
*/

SELECT Förlag AS Namn, Land, title AS Title, genre AS Genre
FROM
    (
        SELECT publisher.country as Land, edition.book, x.value('@Publisher', 'VARCHAR(30)') AS Förlag
        FROM publisher, edition CROSS APPLY translations.nodes('//Translation') AS Translation(x)
        WHERE publisher.name = x.value('@Publisher', 'VARCHAR(30)')
    ) AS Förlag,
    book AS Bok
WHERE NOT(Förlag = 'null') and Bok.id = book
GROUP BY title, Förlag, Genre, Land
ORDER BY Förlag
FOR XML AUTO, ROOT('Resultat')

/*OUTPUT
<Resultat>
  <Förlag Namn="ABC International" Land="Germany">
    <Bok Title="Music Now and Before" Genre="Educational" />
    <Bok Title="Musical Instruments" Genre="Educational" />
    <Bok Title="Oceanography for Dummies" Genre="Educational" />
    <Bok Title="Oceans on Earth" Genre="Educational" />
  </Förlag>
  <Förlag Namn="Addison" Land="France">
    <Bok Title="Misty Nights" Genre="Thriller" />
  </Förlag>
  <Förlag Namn="Aurora Publ." Land="Italy">
    <Bok Title="Le chateau de mon pere" />
  </Förlag>
  <Förlag Namn="Bästa Bok" Land="Sweden">
    <Bok Title="The Fourth Star" Genre="Science Fiction" />
  </Förlag>
  <Förlag Namn="Benton Inc" Land="England">
    <Bok Title="Le chateau de mon pere" />
  </Förlag>
  <Förlag Namn="EU Publishing" Land="Belgium">
    <Bok Title="European History" Genre="Educational" />
  </Förlag>
  <Förlag Namn="Kingsly" Land="Austria">
    <Bok Title="Misty Nights" Genre="Thriller" />
  </Förlag>
  <Förlag Namn="KLC" Land="Sweden">
    <Bok Title="Archeology in Egypt" Genre="Educational" />
  </Förlag>
  <Förlag Namn="Pels And Jafs" Land="Scotland">
    <Bok Title="Encore une fois" />
  </Förlag>
  <Förlag Namn="RP" Land="Russia">
    <Bok Title="Contact" Genre="Science Fiction" />
  </Förlag>
  <Förlag Namn="SCB" Land="Sweden">
    <Bok Title="Contact" Genre="Science Fiction" />
  </Förlag>
  <Förlag Namn="Shou-Ling" Land="China">
    <Bok Title="Archeology in Egypt" Genre="Educational" />
  </Förlag>
  <Förlag Namn="Suomi Bookkii" Land="Finland">
    <Bok Title="Midsommar i Lund" Genre="Novel" />
  </Förlag>
  <Förlag Namn="Turk And Turk" Land="Turkey">
    <Bok Title="Archeology in Egypt" Genre="Educational" />
  </Förlag>
</Resultat>
*/