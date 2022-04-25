(:Seminarium/Inlupp 1 Uppgift 1 :)

(:Ta fram det antal olika personer som har jobbat för varje produktionsbolag! Ett element
per produktionsbolag med namn och antal som attribut. Rotelement Resultat. :)

element Resultat {
    for $f in //Film
    group by $pb := $f/Produktionsbolag

    return element PBolag{
        attribute Namn {$pb},
        attribute Jobbare {
            count(
                distinct-values(
                    (
                        for $t in $f
                        return $t/Regissör/@Namn,
                        for $t in $f
                        return $t/Skådis/@Namn
                    )
                )
            )
        }
    }
}

