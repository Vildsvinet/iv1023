SELECT genre AS "@namn", COUNT(*) AS "@antalböcker",
		(SELECT DISTINCT Language AS "Språk"
		FROM book b,
			(SELECT id AS bookid, originallanguage AS Language
			FROM book
			UNION
			(SELECT book AS bookid, x.value('@Language', 'VARCHAR(20)') as Language
			FROM edition CROSS APPLY translations.nodes('//Translation') AS Translation(x))
			) Språk
		WHERE b.genre = book.genre AND b.id = Språk.bookid
		FOR XML PATH(''), TYPE)
FROM book
WHERE genre IS NOT NULL
GROUP BY genre
FOR XML PATH('Genre'), ROOT('Resultat')


/*
<Resultat>
  <Genre namn="Educational" antalböcker="7">
    <Språk>Bulgarian</Språk>
    <Språk>Chinese</Språk>
    <Språk>Danish</Språk>
    <Språk>Dutch</Språk>
    <Språk>English</Språk>
    <Språk>Finnish</Språk>
    <Språk>French</Språk>
    <Språk>German</Språk>
    <Språk>Greek</Språk>
    <Språk>Italian</Språk>
    <Språk>Norwegian</Språk>
    <Språk>Portuguese</Språk>
    <Språk>Russian</Språk>
    <Språk>Spanish</Språk>
    <Språk>Swedish</Språk>
    <Språk>Turkish</Språk>
  </Genre>
  <Genre namn="Novel" antalböcker="3">
    <Språk>English</Språk>
    <Språk>Finnish</Språk>
    <Språk>Swedish</Språk>
  </Genre>
  <Genre namn="Science Fiction" antalböcker="2">
    <Språk>English</Språk>
    <Språk>German</Språk>
    <Språk>Russian</Språk>
    <Språk>Swedish</Språk>
  </Genre>
  <Genre namn="Thriller" antalböcker="2">
    <Språk>English</Språk>
    <Språk>French</Språk>
    <Språk>German</Språk>
    <Språk>Russian</Språk>
    <Språk>Swedish</Språk>
  </Genre>
</Resultat>
*/