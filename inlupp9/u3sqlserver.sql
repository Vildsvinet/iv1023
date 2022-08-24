/*Inlupp 9.3 sql server*/

SELECT	Märke.brand AS "namn",
		Företag.arbetsgivare AS "namn",
		(
		SELECT COUNT(DISTINCT(person.name))
		FROM CAR JOIN PERSON ON CAR.OWNER = PERSON.PID CROSS APPLY employments.nodes('//employment') AS Employment(x)
		where brand = Märke.brand AND x.value('@employer', 'VARCHAR(10)') = Företag.arbetsgivare
		) AS "antalanställdabilägare"
FROM
	(
	SELECT DISTINCT brand, pid
	FROM CAR JOIN PERSON ON CAR.OWNER = PERSON.PID CROSS APPLY employments.nodes('//employment') AS Employment(x)
	) Märke,
	(
	SELECT DISTINCT pid, x.value('@employer', 'VARCHAR(10)') AS arbetsgivare
	FROM PERSON CROSS APPLY employments.nodes('//employment') AS Employment(x)
	) Företag
WHERE Märke.pid = Företag.pid
GROUP BY Märke.brand, Företag.arbetsgivare
FOR XML AUTO, ROOT('Resultat')


/*
<Resultat>
  <Märke namn="FIAT">
    <Företag namn="ABB" antalanställdabilägare="1" />
    <Företag namn="UPC" antalanställdabilägare="2" />
  </Märke>
  <Märke namn="NISSAN">
    <Företag namn="ABB" antalanställdabilägare="1" />
    <Företag namn="LKP" antalanställdabilägare="1" />
    <Företag namn="STG" antalanställdabilägare="1" />
    <Företag namn="UPC" antalanställdabilägare="1" />
  </Märke>
  <Märke namn="SAAB">
    <Företag namn="ABB" antalanställdabilägare="1" />
    <Företag namn="FFD" antalanställdabilägare="1" />
    <Företag namn="LKP" antalanställdabilägare="1" />
    <Företag namn="STG" antalanställdabilägare="1" />
    <Företag namn="UPC" antalanställdabilägare="1" />
  </Märke>
  <Märke namn="VOLVO">
    <Företag namn="ABB" antalanställdabilägare="1" />
    <Företag namn="FFD" antalanställdabilägare="1" />
    <Företag namn="LKP" antalanställdabilägare="1" />
  </Märke>
</Resultat>
  */