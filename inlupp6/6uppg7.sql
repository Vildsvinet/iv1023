/*Inlupp 6.7
  Ta fram information om på vilka språk varje förlag har böcker!
*/

SELECT publisher.name AS "@namn", publisher.country AS "@land",
        (SELECT DISTINCT x.value('@Language', 'VARCHAR(20)')
        FROM publisher p, edition CROSS APPLY translations.nodes('//Translation') AS Språk(x)
        WHERE p.name = x.value('@Publisher','VARCHAR(20)') AND p.name = publisher.name
        FOR XML AUTO, ELEMENTS, TYPE)
FROM publisher
GROUP BY publisher.name, publisher.country
ORDER BY publisher.name
FOR XML PATH ('Förlag'), ROOT('Resultat')

/*OUTPUT
<Resultat>
  <Förlag namn="ABC International" land="Germany">
    <Språk>Chinese</Språk>
    <Språk>Danish</Språk>
    <Språk>Dutch</Språk>
    <Språk>French</Språk>
    <Språk>German</Språk>
    <Språk>Italian</Språk>
    <Språk>Portuguese</Språk>
    <Språk>Russian</Språk>
    <Språk>Spanish</Språk>
  </Förlag>
  <Förlag namn="Addison" land="France">
    <Språk>French</Språk>
    <Språk>Russian</Språk>
  </Förlag>
  <Förlag namn="Aurora Publ." land="Italy">
    <Språk>Italian</Språk>
  </Förlag>
  <Förlag namn="Bästa Bok" land="Sweden">
    <Språk>Swedish</Språk>
  </Förlag>
  <Förlag namn="Benton Inc" land="England">
    <Språk>English</Språk>
  </Förlag>
  <Förlag namn="EU Publishing" land="Belgium">
    <Språk>Bulgarian</Språk>
    <Språk>Danish</Språk>
    <Språk>Dutch</Språk>
    <Språk>Finnish</Språk>
    <Språk>French</Språk>
    <Språk>Greek</Språk>
    <Språk>Italian</Språk>
    <Språk>Norwegian</Språk>
    <Språk>Portuguese</Språk>
    <Språk>Russian</Språk>
    <Språk>Spanish</Språk>
    <Språk>Swedish</Språk>
  </Förlag>
  <Förlag namn="Kingsly" land="Austria">
    <Språk>German</Språk>
  </Förlag>
  <Förlag namn="KLC" land="Sweden">
    <Språk>French</Språk>
    <Språk>Italian</Språk>
    <Språk>Swedish</Språk>
  </Förlag>
  <Förlag namn="Pels And Jafs" land="Scotland">
    <Språk>English</Språk>
  </Förlag>
  <Förlag namn="RP" land="Russia">
    <Språk>Russian</Språk>
  </Förlag>
  <Förlag namn="SCB" land="Sweden">
    <Språk>Swedish</Språk>
  </Förlag>
  <Förlag namn="Shou-Ling" land="China">
    <Språk>Chinese</Språk>
  </Förlag>
  <Förlag namn="Suomi Bookkii" land="Finland">
    <Språk>Finnish</Språk>
  </Förlag>
  <Förlag namn="Turk And Turk" land="Turkey">
    <Språk>Turkish</Språk>
  </Förlag>
</Resultat>
*/