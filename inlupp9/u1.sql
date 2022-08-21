-- Inlupp 9.1 db2
--  Vem äger bilar i varje färg? Resultatet skall ha följande struktur:


SELECT XMLELEMENT(NAME "Resultat", XMLAGG(colours))
FROM (
         SELECT XMLELEMENT(NAME "Färg", XMLATTRIBUTES(color AS "namn"),
                           XMLAGG(XMLELEMENT(NAME "Person",
                                   XMLATTRIBUTES(cart.NAME AS "namn", empt.antalarbetsgivare AS "antalarbetsgivare",
                                                 empt.antalanställningar AS "antalanställningar")))) AS colours
         FROM (SELECT DISTINCT COLOR, OWNER, NAME
               FROM car,
                    person
               WHERE CAR.OWNER = PERSON.PID) cart,
              (SELECT name, antalarbetsgivare AS antalarbetsgivare, anstallningar AS antalanställningar
               FROM person, XMLTABLE('$e'
                                     PASSING employments AS "e"
                                     COLUMNS
                                     antalarbetsgivare INTEGER PATH 'count(distinct-values(//@employer))',
                                     anstallningar INTEGER PATH 'count(.//employment)')) empt
         WHERE empt.NAME = cart.NAME
         GROUP BY COLOR
     );

/*
<Resultat>
    <Färg namn="black">
        <Person namn="John Higgins" antalarbetsgivare="2" antalanställningar="2"/>
        <Person namn="Ronnie O'Sullivan" antalarbetsgivare="2" antalanställningar="2"/>
    </Färg>
    <Färg namn="blue">
        <Person namn="Stephen Hendry" antalarbetsgivare="2" antalanställningar="3"/>
        <Person namn="Ken Doherty" antalarbetsgivare="4" antalanställningar="5"/>
    </Färg>
    <Färg namn="green">
        <Person namn="Matthew Stevens" antalarbetsgivare="1" antalanställningar="1"/>
    </Färg>
    <Färg namn="red">
        <Person namn="Matthew Stevens" antalarbetsgivare="1" antalanställningar="1"/>
        <Person namn="Steve Davis" antalarbetsgivare="3" antalanställningar="3"/>
    </Färg>
</Resultat>
*/