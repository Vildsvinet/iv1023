SELECT 
    XMLELEMENT(NAME "Resultat", XMLAGG(hold)) 
FROM
(
    SELECT 
        XMLELEMENT(
            NAME "Kurstillf�lle", 
            XMLATTRIBUTES(kurskod AS "kurskod", kursben AS "kursnamn", sdat AS "startdatum", lokal as "lokal"),
            XMLELEMENT(
                NAME "L�rare", 
                l�rare.lnamn
            ),
            XMLELEMENT(
                NAME "AntalElever", 
                (SELECT 
                    COUNT(*) 
                    FROM deltag 
                    WHERE deltag.sdat = ktillf.sdat AND deltag.kurs = ktillf.kurs)
            )
        ) AS hold                                                                                                                                              
    FROM ktillf, kurs, l�rare
    WHERE ktillf.kurs = kurs.kurskod AND l�rare.lid = ktillf.l�rare
)