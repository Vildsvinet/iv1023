--Den senaste upplagan (edition) av boken "Encore une fois" har översatts till norska och
--kostar 200 kronor. Den är utgiven av förlaget KLC. Gör ändringen i databasen
--

UPDATE Edition
SET translations =
        XMLQUERY('
		transform
		copy $res := $t
		modify do insert element
			Translation {attribute Language {"Norwegian"}, attribute Publisher {"KLC"}, attribute Price {200}}
		as last into $res/Translations
		return $res'
            PASSING translations AS "t"
        )
WHERE edition.id =
      (SELECT edition.id
       FROM book, edition
       WHERE book.title = 'Encore une fois'
         AND edition.book = book.id
         AND edition.year = (SELECT MAX(edition.year)
                             FROM edition, book
                             WHERE edition.book = book.id
                               AND book.title = 'Encore une fois'
                            )
      )

-- OUTPUT:
--  TITLE           	TRANSLATIONS
--  --------------- 	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Encore une fois	<Translations><Translation Language="English" Publisher="Pels And Jafs" Price="180"/><Translation Language="Russian" Price="140"/><Translation Language="Norwegian" Publisher="KLC" Price="200"/><Translation Language="Norwegian" Publisher="KLC" Price="200"/><Translation Language="Norwegian" Publisher="KLC" Price="200"/><Translation Language="Norwegian" Publisher="KLC" Price="200"/></Translations>