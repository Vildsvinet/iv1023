SELECT XMLELEMENT(NAME "Resultat", XMLAGG(cntrs))
FROM (
         SELECT XMLELEMENT(
                        NAME "Land",
                        XMLATTRIBUTES(country as "namn"),
                        XMLAGG(XMLELEMENT(NAME "Stad", XMLATTRIBUTES(city as "namn", antalförlag as "antalförlag")))
                    ) AS cntrs
         FROM (
                  SELECT city, country, COUNT(*) as antalförlag
                  FROM publisher
                  GROUP BY city, country
              )
         GROUP BY country
     )

/*
<Resultat>
    <Land namn="Austria">
        <Stad namn="Vienna" antalförlag="1"></Stad>
    </Land>
    <Land namn="Belgium">
        <Stad namn="Brussels" antalförlag="1"></Stad>
    </Land>
    <Land namn="China">
        <Stad namn="Shanghai" antalförlag="1"></Stad>
    </Land>
    <Land namn="England">
        <Stad namn="London" antalförlag="1"></Stad>
    </Land>
    <Land namn="Finland">
        <Stad namn="Helsinki" antalförlag="1"></Stad>
    </Land>
    <Land namn="France">
        <Stad namn="Toulouse" antalförlag="1"></Stad>
    </Land>
    <Land namn="Germany">
        <Stad namn="Berlin" antalförlag="1"></Stad>
    </Land>
    <Land namn="Italy">
        <Stad namn="Florence" antalförlag="1"></Stad>
    </Land>
    <Land namn="Russia">
        <Stad namn="Saint Petersburg" antalförlag="1"></Stad>
    </Land>
    <Land namn="Scotland">
        <Stad namn="Edinburg" antalförlag="1"></Stad>
    </Land>
    <Land namn="Sweden">
        <Stad namn="Stockholm" antalförlag="2"></Stad>
        <Stad namn="Uppsala" antalförlag="1"></Stad>
    </Land>
    <Land namn="Turkey">
        <Stad namn="Ankara" antalförlag="1"></Stad>
    </Land>
</Resultat>
*/