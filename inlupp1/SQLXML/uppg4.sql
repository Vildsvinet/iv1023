SELECT 
    XMLELEMENT(NAME "Resultat", XMLAGG(elevtabell.elever))
FROM
(
    SELECT 
        XMLELEMENT(
            NAME "Elev", 
            XMLATTRIBUTES(elev.enamn AS "namn"),
            XMLAGG(XMLELEMENT(NAME "Lokal",Ktillf.lokal)) 
        ) AS elever
    FROM Deltag, Elev, Ktillf
    WHERE Deltag.elev = elev.eid AND Deltag.kurs = Ktillf.kurs AND Deltag.sdat = Ktillf.sdat
    GROUP BY elev.enamn
) elevtabell
