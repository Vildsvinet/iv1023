(: Uppgift 2.3 Vilka böcker har översatts till ryska och minst ett språk till? :)

element Resultat{
    for $b in //Book
    let $t := $b/@Title
    order by $t
    where $b//Translation/@Language="Russian"
            and $b//Translation/@Language!="Russian"
    return(
        element Bok{
            attribute Titel {$b/@Title},
            attribute Originalspråk {$b/@OriginalLanguage},
            attribute Antalandraspråk{
                count(distinct-values($b//Translation/@Language))-1
            }
        }
    )
}

(:
Output

<Resultat>
  <Bok Titel="Contact" Originalspråk="English" Antalandraspråk="2"/>
  <Bok Titel="Encore une fois" Originalspråk="French" Antalandraspråk="1"/>
  <Bok Titel="European History" Originalspråk="English" Antalandraspråk="11"/>
  <Bok Titel="Misty Nights" Originalspråk="English" Antalandraspråk="2"/>
  <Bok Titel="Music Now and Before" Originalspråk="English" Antalandraspråk="3"/>
  <Bok Titel="Musical Instruments" Originalspråk="English" Antalandraspråk="6"/>
</Resultat>
:)
