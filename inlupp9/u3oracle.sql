SELECT XMLELEMENT(NAME "Resultat", XMLAGG(mrkn))
FROM(
    SELECT XMLELEMENT(NAME "Märke",
                    XMLATTRIBUTES(brand AS "namn"),
                    XMLAGG( XMLELEMENT(NAME "Företag",
                            XMLATTRIBUTES(arbetsgivare AS "namn",
                                (
                                    SELECT COUNT(DISTINCT (PERSON.NAME)) as antal
                                    FROM CAR JOIN PERSON ON CAR.OWNER = PERSON.PID,
                                        XMLTABLE('$e//employment'
                                                 PASSING employments AS "e"
                                                 COLUMNS
                                                 arbgivare VARCHAR(10) PATH '@employer'
                                        )
                                    WHERE brand = yttre.brand AND arbetsgivare = yttre.arbetsgivare
                                    GROUP BY arbetsgivare
                                ) AS "antalanställdabilägare"
                            )
                        ))
                    ) mrkn
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
)
;

/*
<Resultat>
    <Märke namn="FIAT">
        <Företag namn="UPC" antalanställdabilägare="2"></Företag>
        <Företag namn="ABB" antalanställdabilägare="1"></Företag>
    </Märke>
    <Märke namn="NISSAN">
        <Företag namn="ABB" antalanställdabilägare="1"></Företag>
        <Företag namn="STG" antalanställdabilägare="1"></Företag>
        <Företag namn="LKP" antalanställdabilägare="1"></Företag>
        <Företag namn="UPC" antalanställdabilägare="1"></Företag>
    </Märke>
    <Märke namn="SAAB">
        <Företag namn="STG" antalanställdabilägare="1"></Företag>
        <Företag namn="FFD" antalanställdabilägare="1"></Företag>
        <Företag namn="UPC" antalanställdabilägare="1"></Företag>
        <Företag namn="LKP" antalanställdabilägare="1"></Företag>
        <Företag namn="ABB" antalanställdabilägare="1"></Företag>
    </Märke>
    <Märke namn="VOLVO">
        <Företag namn="LKP" antalanställdabilägare="1"></Företag>
        <Företag namn="FFD" antalanställdabilägare="1"></Företag>
        <Företag namn="ABB" antalanställdabilägare="1"></Företag>
    </Märke>
</Resultat>
*/