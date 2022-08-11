
SELECT XMLELEMENT(NAME "Resultat", XMLAGG(cntrs))
FROM (
         SELECT XMLELEMENT(
                        NAME "Land",
                        XMLATTRIBUTES(country as "namn"),
                        XMLAGG(cts)
                    ) AS cntrs
         FROM (
                  SELECT t1.city,
                         country,
                         XMLELEMENT(NAME "Stad", XMLATTRIBUTES(t1.city as "namn", antalförlag as "antalförlag")) as cts
                  FROM (
                           SELECT DISTINCT city, country
                           FROM publisher
                       ) t1,
                       (
                           SELECT city, COUNT(*) as antalförlag
                           FROM publisher
                           GROUP BY city
                       ) t2
                  WHERE t1.city = t2.city
              )
         group by country
     )

/*
<Resultat>
    <Land namn="Austria">
        <Stad namn="Vienna" antalförlag="1"/>
    </Land>
    <Land namn="Belgium">
        <Stad namn="Brussels" antalförlag="1"/>
    </Land>
    <Land namn="China">
        <Stad namn="Shanghai" antalförlag="1"/>
    </Land>
    <Land namn="England">
        <Stad namn="London" antalförlag="1"/>
    </Land>
    <Land namn="Finland">
        <Stad namn="Helsinki" antalförlag="1"/>
    </Land>
    <Land namn="France">
        <Stad namn="Toulouse" antalförlag="1"/>
    </Land>
    <Land namn="Germany">
        <Stad namn="Berlin" antalförlag="1"/>
    </Land>
    <Land namn="Italy">
        <Stad namn="Florence" antalförlag="1"/>
    </Land>
    <Land namn="Russia">
        <Stad namn="Saint Petersburg" antalförlag="1"/>
    </Land>
    <Land namn="Scotland">
        <Stad namn="Edinburg" antalförlag="1"/>
    </Land>
    <Land namn="Sweden">
        <Stad namn="Stockholm" antalförlag="2"/>
        <Stad namn="Uppsala" antalförlag="1"/>
    </Land>
    <Land namn="Turkey">
        <Stad namn="Ankara" antalförlag="1"/>
    </Land>
</Resultat>
*/