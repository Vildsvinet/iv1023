/*Inlupp 4.8
  Det har visat sig att den franska översättningen av 1999-års upplaga av "Archeology in
  Egypt" är utgiven av förlaget "ABC International" och inte av "KLC". Gör ändringen i databasen!
*/

UPDATE Edition
SET Translations =
        XMLQUERY('
		transform
		copy $res := $t
		modify do replace value of
			$res//Translation[@Language="French"]/@Publisher with "ABC International"
		return $res'
        PASSING Translations as "t"
        )
WHERE Edition.id =
      (SELECT Edition.id
       FROM Edition, Book
       WHERE Edition.book = Book.id
         AND Book.title = 'Archeology in Egypt'
         AND Edition.year = 1999
       )

/*OUTPUT
 TITLE                        	YEAR 	TRANSLATIONS
 ---------------------------- 	---- 	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Archeology in Egypt         	1999	<Translations><Translation Language="French" Publisher="ABC International" Price="320"/><Translation Language="Italian" Publisher="KLC" Price="320"/><Translation Language="Turkish" Publisher="Turk And Turk" Price="300"/><Translation Language="Spanish" Price="300"/></Translations>
*/