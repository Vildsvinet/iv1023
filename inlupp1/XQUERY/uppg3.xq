(: Seminarium/Inlupp 1 Uppgift 3  :)
(: Ta fram skådespelare som varje regissör har regisserat minst stvå gånger :)

element Resultat{
  for $r in //Regissör
  let $n := $r/@Namn
  group by $n
  return 
  <Regissör Namn="{distinct-values($r/@Namn)}" 
            Land="{distinct-values($r/@Land)}" 
            År="{distinct-values($r/@Födelseår)}">{
    for $s in $r/../Skådis where count($r/../Skådis[@Namn = $s/@Namn])>1
    let $sn := $s/@Namn
    group by $sn
    return <Skådis Namn="{distinct-values($s/@Namn)}" 
                   Land="{distinct-values($s/@Land)}"/>
    }
  </Regissör>
}
