/*Inlupp 9.4 sql server
  Vilka företag har aldrig anställt någon som äger en NISSAN? */

SELECT arbetsgivare AS "företagsnamn"
FROM(
	SELECT DISTINCT x.value('@employer', 'VARCHAR(10)') as arbetsgivare
	FROM PERSON CROSS APPLY employments.nodes('//employment') AS Employment(x)

	EXCEPT

	SELECT DISTINCT x.value('@employer', 'VARCHAR(10)') as arbetsgivare
	FROM CAR FULL JOIN PERSON ON CAR.OWNER = PERSON.PID CROSS APPLY employments.nodes('//employment') AS Employment(x)
	WHERE brand='NISSAN'
) t


/*resultat
företagsnamn
FFD
  */