(: Seminarium/Inlupp 1 Uppgift 2  :)
(: Ta fram antal skådespelare per land för varje film! :)

element Resultat {
   for $f in //Film
    return 
     <Film titel="{$f/@Titel}"> 
     {
       for $t in $f/Skådis
        group by $l := $t/@Land
        return <Land namn="{$l}" antalskådisar="{count($t/@Land)}"/>
     }
     </Film>
}

(:om vi vill göra med element konstruktorer blir det något i stil med  :)

(: element Resultat {
for $f in //Film
return element Film {$f/@Titel, 
for $t in $f/Skådis
group by $l := $t/@Land
return element Land{ 
  attribute namn {$f/Skådis/@Land}, 
  attribute antalskådisar {count($f/Skådis/@Land)}}}
} :) 