SELECT person.NAME, arbetsgivare AS företag,
       XMLELEMENT(NAME "Märke", XMLATTRIBUTES(brand AS "namn"))
FROM CAR JOIN PERSON ON CAR.OWNER = PERSON.PID,
     XMLTABLE('$e//employment'
         PASSING employments AS "e"
         COLUMNS
         arbetsgivare VARCHAR(10) PATH '@employer'
        )