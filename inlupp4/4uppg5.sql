/*Inlupp 4.5
  Den senaste upplagan (edition) av boken "Encore une fois" har översatts till norska och
  kostar 200 kronor. Den är utgiven av förlaget KLC. Gör ändringen i databasen
*/
--
UPDATE Edition
SET translations =
    XMLQUERY('
        transform
        copy $res := $t
        modify do insert element
            Translation {attribute Language {"GURKA"}, attribute Publisher {"KLC"}, attribute Price {200}}
        as last into $res/Translations
        return $res'
                 PASSING translations AS "t"
    )
WHERE edition.id =
    (
    SELECT id FROM
        (
            SELECT edition.id, edition.year
            FROM book, edition
            WHERE title = 'Encore une fois'
            AND book.id = edition.book
            ORDER BY edition.year DESC
        )
        FETCH FIRST 1 ROWS ONLY
    )



/*OUTPUT
  TITLE           	TRANSLATIONS
  --------------- 	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Encore une fois	<Translations><Translation Language="English" Publisher="Pels And Jafs" Price="180"/><Translation Language="Russian" Price="140"/><Translation Language="Norwegian" Publisher="KLC" Price="200"/><Translation Language="Norwegian" Publisher="KLC" Price="200"/><Translation Language="Norwegian" Publisher="KLC" Price="200"/><Translation Language="Norwegian" Publisher="KLC" Price="200"/></Translations>
*/