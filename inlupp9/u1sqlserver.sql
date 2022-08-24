--Inlupp 9.1 microsoft sql server
SELECT color AS "@namn",
	(SELECT	name AS "@namn",
		COUNT(DISTINCT(x.value('@employer','VARCHAR(10)'))) AS "@antalarbetsgivare",
		COUNT(DISTINCT(x.value('@startdate','DATE'))) AS "@antalanställningar"
	FROM car JOIN person ON CAR.OWNER = PERSON.PID
		CROSS APPLY employments.nodes('//employment') AS Employment(x)
	WHERE car.color = c.color
	GROUP BY name
	FOR XML PATH('Person'), TYPE)
FROM car c
GROUP BY color
ORDER BY color
FOR XML PATH('Färg'), ROOT('Resultat')

/*RESULTAT
<Resultat>
  <Färg namn="black">
    <Person namn="John Higgins" antalarbetsgivare="2" antalanställningar="2" />
    <Person namn="Ronnie O'Sullivan" antalarbetsgivare="2" antalanställningar="2" />
  </Färg>
  <Färg namn="blue">
    <Person namn="Ken Doherty" antalarbetsgivare="4" antalanställningar="5" />
    <Person namn="Stephen Hendry" antalarbetsgivare="2" antalanställningar="3" />
  </Färg>
  <Färg namn="green">
    <Person namn="Matthew Stevens" antalarbetsgivare="1" antalanställningar="1" />
  </Färg>
  <Färg namn="red">
    <Person namn="Matthew Stevens" antalarbetsgivare="1" antalanställningar="1" />
    <Person namn="Steve Davis" antalarbetsgivare="3" antalanställningar="3" />
  </Färg>
</Resultat>
  */