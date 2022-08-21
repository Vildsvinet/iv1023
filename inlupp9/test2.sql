SELECT XMLELEMENT(NAME "Resultat", XMLAGG(colours))
FROM (
         SELECT XMLELEMENT(NAME "Färg", xmlattributes(color AS "namn"),
                           XMLAGG(XMLELEMENT(NAME "Person", name))) AS colours
         FROM (SELECT DISTINCT COLOR, OWNER, NAME
               FROM CAR,
                    PERSON
               WHERE CAR.OWNER = PERSON.PID)
         GROUP BY COLOR
)