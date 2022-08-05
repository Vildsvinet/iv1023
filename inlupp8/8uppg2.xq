element Böcker {
    for $b in //Book
    let $g := $b/@Genre
    let $t := $b/@Title
    order by $t
    return(
        if ($g = "Science Fiction" or $g = "Thriller") then
            <Bra> {data($t)} </Bra>
        else if (exists($g)) then
            <Dålig> {data($t)} </Dålig>
        else
            <Oklar> {data($t)} </Oklar>
    )
}

(: OUTPUT
<Böcker>
  <Dålig>Archeology in Egypt</Dålig>
  <Bra>Contact</Bra>
  <Dålig>Database Systems in Practice</Dålig>
  <Bra>Dödliga Data</Bra>
  <Oklar>Encore une fois</Oklar>
  <Dålig>European History</Dålig>
  <Oklar>Le chateau de mon pere</Oklar>
  <Dålig>Midsommar i Lund</Dålig>
  <Bra>Misty Nights</Bra>
  <Dålig>Music Now and Before</Dålig>
  <Dålig>Musical Instruments</Dålig>
  <Dålig>Oceanography for Dummies</Dålig>
  <Dålig>Oceans on Earth</Dålig>
  <Dålig>The Beach House</Dålig>
  <Dålig>The Fifth Star</Dålig>
  <Bra>The Fourth Star</Bra>
  <Dålig>Våren vid sjön</Dålig>
</Böcker>
:)