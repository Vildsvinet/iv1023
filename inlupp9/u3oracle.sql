
SELECT XMLELEMENT(NAME "Märke",
                XMLATTRIBUTES(brand AS "namn"),
                XMLAGG( XMLELEMENT(NAME "Företag",
                        XMLATTRIBUTES(arbetsgivare AS "namn"
                            ,
                            (
                                SELECT COUNT(DISTINCT (PERSON.NAME)) as antal FROM CAR JOIN PERSON ON CAR.OWNER = PERSON.PID,
                                    XMLTABLE('$e//employment'
                                             PASSING employments AS "e"
                                             COLUMNS
                                             arbetsgivare VARCHAR(10) PATH '@employer'
                                    )
                                WHERE brand = yttre.BRAND AND arbetsgivare = yttre.arbetsgivare
                                GROUP BY arbetsgivare
                                )
                             AS "antalbilägare"
                        )
                    ))
                )

FROM (
    SELECT distinct arbetsgivare, brand
    FROM CAR JOIN PERSON ON CAR.OWNER = PERSON.PID,
        XMLTABLE('$e//employment'
               PASSING employments AS "e"
               COLUMNS
               arbetsgivare VARCHAR(10) PATH '@employer'
        )
    ) yttre
GROUP BY BRAND


;SELECT XMLELEMENT(NAME "Märke",
                XMLATTRIBUTES(brand AS "namn"),
                XMLAGG( XMLELEMENT(NAME "Företag",
                        XMLATTRIBUTES(arbetsgivare AS "namn"
                            ,
                            (
                            SELECT antal
                            FROM (
                                SELECT arbetsgivare, COUNT(DISTINCT (PERSON.NAME)) as antal FROM CAR JOIN PERSON ON CAR.OWNER = PERSON.PID,
                                    XMLTABLE('$e//employment'
                                             PASSING employments AS "e"
                                             COLUMNS
                                             arbetsgivare VARCHAR(10) PATH '@employer'
                                    )
                                WHERE brand = yttre.BRAND AND arbetsgivare = yttre.arbetsgivare
                                GROUP BY arbetsgivare
                                )
                            ) AS "antalbilägare"
                        ))
                )
    )
FROM (
    SELECT distinct arbetsgivare, brand
    FROM CAR JOIN PERSON ON CAR.OWNER = PERSON.PID,
        XMLTABLE('$e//employment'
               PASSING employments AS "e"
               COLUMNS
               arbetsgivare VARCHAR(10) PATH '@employer'
        )
    ) yttre
GROUP BY BRAND
;





SELECT arbetsgivare AS företag, person.NAME,
       XMLELEMENT(NAME "Märke", XMLATTRIBUTES(brand AS "namn"))
FROM CAR
         JOIN PERSON ON CAR.OWNER = PERSON.PID,
    XMLTABLE('$e//employment'
             PASSING employments AS "e"
             COLUMNS
             arbetsgivare VARCHAR(10) PATH '@employer'
        )
ORDER BY företag
;

SELECT arbetsgivare, COUNT(DISTINCT (PERSON.NAME)) as antal
FROM CAR
         JOIN PERSON ON CAR.OWNER = PERSON.PID,
    XMLTABLE('$e//employment'
             PASSING employments AS "e"
             COLUMNS
             arbetsgivare VARCHAR(10) PATH '@employer'
        )
WHERE brand = 'FIAT'
group by arbetsgivare
;