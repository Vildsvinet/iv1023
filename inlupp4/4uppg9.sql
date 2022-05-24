/*Inlupp 4.9
  Ta fram information om böckerna i databasen!
*/

XQUERY
element Resultat{
    for $row in
        db2-fn:sqlquery('
        SELECT XMLELEMENT(NAME "Språk", XMLATTRIBUTES(OriginalLanguage AS "namn", COUNT(Book.OriginalLanguage) AS "antalböcker"))
        FROM Book
        GROUP BY OriginalLanguage')
    return $row
}

/*OUTPUT
<Resultat>
    <Språk namn="English" antalböcker="12"/>
    <Språk namn="French" antalböcker="2"/>
    <Språk namn="Swedish" antalböcker="3"/>
</Resultat>
*/