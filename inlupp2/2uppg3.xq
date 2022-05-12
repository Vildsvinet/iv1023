(: Uppgift 2.3 Vilka böcker har översatts till ryska och minst ett språk till? :)

element Resultat{
    for $b in //Book
    let $t := distinct-values($b/@Title)
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
    <Bok Titel="Contact" Originalsprak="English" Antalandrasprak="2"/>
    <Bok Titel="Encore une fois" Originalsprak="French" Antalandrasprak="1"/>
    <Bok Titel="European History" Originalsprak="English" Antalandrasprak="11"/>
    <Bok Titel="Misty Nights" Originalsprak="English" Antalandrasprak="2"/>
    <Bok Titel="Music Now and Before" Originalsprak="English" Antalandrasprak="3"/>
    <Bok Titel="Musical Instruments" Originalsprak="English" Antalandrasprak="6"/>
</Resultat>:)
