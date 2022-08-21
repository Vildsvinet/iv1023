--  Vem äger bilar i varje färg? Resultatet skall ha följande struktur:
-- <Resultat>
-- <Färg namn="">
-- <Person namn="" antalarbetsgivare="" antalanställningar="" />
-- <Person namn="" antalarbetsgivare="" antalanställningar="" />
-- </Färg>
-- <Färg namn="">
-- <Person namn="" antalarbetsgivare="" antalanställningar="" />
-- <Person namn="" antalarbetsgivare="" antalanställningar="" />
-- </Färg>
-- </Resultat>

SELECT XMLELEMENT(NAME "Resultat", XMLAGG(colours))
FROM (
         SELECT XMLELEMENT(NAME "Färg", XMLATTRIBUTES(color AS "namn"),
                           XMLAGG(XMLELEMENT(NAME "Person", name))) AS colours
         FROM (SELECT DISTINCT COLOR, OWNER, NAME
               FROM CAR,
                    PERSON
               WHERE CAR.OWNER = PERSON.PID)
            ,
              (SELECT EMPLOYMENTS FROM PERSON)
            ,
              XMLTABLE('$e//Employment'
                  PASSING employments AS "e"
                  COLUMNS arbetsgivare VARCHAR(10) PATH '@employer')
         GROUP BY COLOR
)


SELECT name, antalarbetsgivare AS antalarbetsgivare, anstallningar AS antalanställningar

FROM       person, XMLTABLE('$e'
                  PASSING employments AS "e"
                  COLUMNS
                    antalarbetsgivare INTEGER PATH 'count(distinct-values(//@employer))',
                    anstallningar XML PATH 'count($e//employment)')

                  ;