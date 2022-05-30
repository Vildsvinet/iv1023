/*Inlupp 4.7
  Ta fram information om på vilka språk varje förlag har böcker!
  Feedback
  - Varför använder ni tabellen Publisher två gånger?
    Svar : det ska vara ändrat nu, osäker på om du ville ha ännu mer förenkling men då ändrar vi igen :)
*/

SELECT XMLELEMENT(NAME "Resultat", XMLAGG(förlagtabell.förlag))
FROM (SELECT XMLELEMENT(NAME "Förlag",
                        XMLATTRIBUTES(språktabell.förlagsnamn AS "namn", språktabell.förlagsland AS "land"),
                        XMLAGG(språktabell.språk)
                 ) förlag
      FROM (SELECT Publisher.name                     AS förlagsnamn,
                   Publisher.country                  AS förlagsland,
                   XMLELEMENT(NAME "Språk", tt.språk) AS språk
            FROM Publisher,
                 Edition,
                 XMLTABLE('$t//Translation'
                        PASSING translations AS "t"
                        COLUMNS Förlag VARCHAR(30) PATH '@Publisher',
                                Språk VARCHAR(15) PATH '@Language'
                     ) tt
            WHERE Publisher.name = tt.Förlag
            GROUP BY Publisher.name, Publisher.country, tt.Språk
            ORDER BY Publisher.name, tt.Språk) språktabell
      GROUP BY språktabell.förlagsnamn, språktabell.förlagsland) förlagtabell

/* OUTPUT:
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
        <Språk>Norwegian</Språk>
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