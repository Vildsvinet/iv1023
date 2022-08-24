SELECT DISTINCT arbetsgivare, personnamn, DATEDIFF(day, startdatum, getdate()), count(owner) AS antbilar
FROM
	(SELECT	x.value('@employer', 'VARCHAR(10)') AS arbetsgivare,
			name AS personnamn,
			x.value('@startdate', 'DATE') AS startdatum,
			x.value('@enddate', 'DATE') AS slutdatum,
			owner
	FROM car FULL JOIN person ON CAR.OWNER = PERSON.PID
		CROSS APPLY employments.nodes('//employment') AS Employment(x)
	) t
WHERE slutdatum IS NULL
group by personnamn, arbetsgivare, startdatum
ORDER BY arbetsgivare, personnamn

/*
ABB	Neil Robertson	5025	0
ABB	Stephen Hendry	5775	1
FFD	Steve Davis	4952	1
STG	Ken Doherty	5196	1
STG	Ronnie O'Sullivan	4392	1
UPC	John Higgins	4879	2
UPC	Matthew Stevens	7166	2
UPC	Stephen Hendry	6963	1
*/