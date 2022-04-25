SELECT 
    XMLELEMENT(NAME "Resultat", XMLAGG(hold)) 
FROM
(
    SELECT 
        XMLELEMENT(
            NAME "Kurstillfälle", 
            XMLATTRIBUTES(kurskod AS "kurskod", kursben AS "kursnamn", sdat AS "startdatum", lokal as "lokal"),
            XMLELEMENT(
                NAME "Lärare", 
                lärare.lnamn
            ),
            XMLELEMENT(
                NAME "AntalElever", 
                (SELECT 
                    COUNT(*) 
                    FROM deltag 
                    WHERE deltag.sdat = ktillf.sdat AND deltag.kurs = ktillf.kurs)
            )
        ) AS hold                                                                                                                                              
    FROM ktillf, kurs, lärare
    WHERE ktillf.kurs = kurs.kurskod AND lärare.lid = ktillf.lärare
)