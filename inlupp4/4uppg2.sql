/*Inlupp 4.2
  Vilka böckers översättningar har publicerats av varje förlag?
*/

SELECT XMLELEMENT(NAME "Resultat", XMLAGG(XMLELEMENT(NAME "Förlag", XMLATTRIBUTES(förlagsnamn AS "Namn", förlagsland AS "Land"), boklista)))
FROM
    (
        SELECT Publisher.name AS förlagsnamn, Publisher.country AS förlagsland, XMLAGG(t2.bokelement) AS boklista
        FROM Publisher,
             (
                 SELECT Book.title AS boktitel, tt.Förlag AS förlagsnamn, XMLELEMENT(NAME "Bok", XMLATTRIBUTES(Book.title AS "Titel", Book.genre AS "Genre")) AS bokelement
                 FROM Edition, Book,
                      XMLTABLE('$t//Translation'
                               PASSING translations AS "t"
                               COLUMNS Förlag VARCHAR(30) PATH '@Publisher'
                          ) tt
                 WHERE Edition.book = Book.id
                 GROUP BY Book.title, Book.genre, tt.Förlag
             ) t2
        WHERE Publisher.name = t2.förlagsnamn
        GROUP BY Publisher.name, Publisher.country
    )

/*OUTPUT
  <Resultat>
    <Förlag Namn="ABC International" Land="Germany">
        <Bok Titel="Archeology in Egypt" Genre="Educational"/>
        <Bok Titel="Music Now and Before" Genre="Educational"/>
        <Bok Titel="Musical Instruments" Genre="Educational"/>
        <Bok Titel="Oceanography for Dummies" Genre="Educational"/>
        <Bok Titel="Oceans on Earth" Genre="Educational"/>
    </Förlag>
    <Förlag Namn="Addison" Land="France">
        <Bok Titel="Misty Nights" Genre="Thriller"/>
    </Förlag>
    <Förlag Namn="Aurora Publ." Land="Italy">
        <Bok Titel="Le chateau de mon pere"/>
    </Förlag>
    <Förlag Namn="Bästa Bok" Land="Sweden">
        <Bok Titel="The Fifth Star" Genre="Novel"/>
        <Bok Titel="The Fourth Star" Genre="Science Fiction"/>
    </Förlag>
    <Förlag Namn="Benton Inc" Land="England">
        <Bok Titel="Le chateau de mon pere"/>
    </Förlag>
    <Förlag Namn="EU Publishing" Land="Belgium">
        <Bok Titel="European History" Genre="Educational"/>
    </Förlag>
    <Förlag Namn="Kingsly" Land="Austria">
        <Bok Titel="Misty Nights" Genre="Thriller"/>
    </Förlag>
    <Förlag Namn="KLC" Land="Sweden">
        <Bok Titel="Archeology in Egypt" Genre="Educational"/>
        <Bok Titel="Encore une fois"/>
    </Förlag>
    <Förlag Namn="Pels And Jafs" Land="Scotland">
        <Bok Titel="Encore une fois"/>
    </Förlag>
    <Förlag Namn="RP" Land="Russia">
        <Bok Titel="Contact" Genre="Science Fiction"/>
    </Förlag>
    <Förlag Namn="SCB" Land="Sweden">
        <Bok Titel="Contact" Genre="Science Fiction"/>
    </Förlag>
    <Förlag Namn="Shou-Ling" Land="China">
        <Bok Titel="Archeology in Egypt" Genre="Educational"/>
    </Förlag>
    <Förlag Namn="Suomi Bookkii" Land="Finland">
        <Bok Titel="Midsommar i Lund" Genre="Novel"/>
    </Förlag>
    <Förlag Namn="Turk And Turk" Land="Turkey">
        <Bok Titel="Archeology in Egypt" Genre="Educational"/>
    </Förlag>
  </Resultat>
*/