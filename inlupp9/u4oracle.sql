/*Inlupp 9.4 oracle
  Vilka företag har aldrig anställt någon som äger en NISSAN? */

SELECT arbetsgivare AS "företagsnamn"
FROM (
         SELECT DISTINCT arbetsgivare
         FROM PERSON, XMLTABLE('$e//employment'
                               PASSING employments AS "e"
                               COLUMNS
                               arbetsgivare VARCHAR(10) PATH '@employer'
             )
         MINUS
         SELECT DISTINCT arbetsgivare
         FROM CAR
                  FULL JOIN PERSON ON CAR.OWNER = PERSON.PID,
             XMLTABLE('$e//employment'
                      PASSING employments AS "e"
                      COLUMNS
                      arbetsgivare VARCHAR(10) PATH '@employer'
                 )
         WHERE brand = 'NISSAN'
     )
;

/*Resultat
företagsnamn
----------
FFD
*/