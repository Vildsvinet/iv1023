/*Inlupp 6.8
  Det har visat sig att den franska översättningen av 1999-års upplaga av "Archeology in
  Egypt" är utgiven av förlaget "ABC International" och inte av "KLC". Gör ändringen i databasen!
*/

UPDATE edition
SET translations.modify
    ('
		replace value of (//Translation[@Language="French"]/@Publisher)[1] with "ABC International"
	')
FROM book
WHERE edition.book = book.id
  AND book.title = 'Archeology in Egypt'
  AND edition.year = 1999

/*OUTPUT
<Translations>
  <Translation Language="French" Publisher="ABC International" Price="320" />
  <Translation Language="Italian" Publisher="KLC" Price="320" />
  <Translation Language="Turkish" Publisher="Turk And Turk" Price="300" />
  <Translation Language="Spanish" Price="300" />
</Translations>
*/