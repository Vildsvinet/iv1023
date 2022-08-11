/* Hur många böcker finns det i varje genre och på vilka språk? */

DECLARE @xml XML = (SELECT *
    FROM book CROSS APPLY
    (SELECT translations FROM edition WHERE book=book.id) as translations
	WHERE genre IS NOT NULL
    FOR XML AUTO, ELEMENTS, ROOT('Books')
)

DECLARE @books XML = (
    SELECT
        item.row.value('title[1]', 'varchar(20)') "@Titel",
        item.row.value('genre[1]', 'varchar(20)') "@Genre",
        item.row.value('originallanguage[1]', 'varchar(20)') "Språk",
        item.row.query('for $l in distinct-values(.//Translation/@Language) return <Språk> {data($l)} </Språk> ')
    FROM @xml.nodes('//book') item(row)
    FOR XML PATH('Book'), ROOT('Books')
)

--SELECT @books

SELECT
    item.x.query('
		for $g in distinct-values(//Book/@Genre)
		order by $g
		return
			<Genre namn="{$g}" antalböcker="{count(//Book[@Genre=$g])}">
				{
				for $l in distinct-values(//Språk[../@Genre=$g])
				order by $l
				return <Språk> {$l} </Språk>
				}
			</Genre>
		')
FROM @books.nodes('Books') item(x)
FOR XML PATH(''), ROOT('Resultat')


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