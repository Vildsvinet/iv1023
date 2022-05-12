(: Inlupp 2.1 Vilka böcker har flera utgåvor (editions)? :) 

element Resultat{
  for $b in //Book
  let $t := $b/@Title
  where count($b//Edition)>1
  order by $t
  return
    <Bok Titel="{$t}"/>
}


(:Output:)
(:
<Resultat>
  <Book Titel="Archeology in Egypt"/>
  <Book Titel="Database Systems in Practice"/>
  <Book Titel="Våren vid sjön"/>
  <Book Titel="Music Now and Before"/>
  <Book Titel="Encore une fois"/>
  <Book Titel="Musical Instruments"/>
  <Book Titel="Oceans on Earth"/>
  <Book Titel="Oceanography for Dummies"/>
</Resultat>:)
