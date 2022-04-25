SELECT
    XMLELEMENT(NAME "Resultat", XMLAGG(kurslangder))
FROM(   
    SELECT  
        XMLELEMENT(
            NAME "Kurslängd",
            XMLATTRIBUTES(
                längd AS "antalveckor",
                AVG(pris) AS "snittpris"
            )
        ) AS kurslangder
    FROM 
        Kurs, 
        XMLTABLE('$x//info'
                PASSING Info AS "x"
            COLUMNS 
                längd INTEGER PATH '//längd',
                pris INTEGER PATH '//pris'
    
        ) AS k
    GROUP BY k.längd
    ORDER BY k.längd
)      
