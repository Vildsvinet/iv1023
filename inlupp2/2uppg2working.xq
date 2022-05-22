element Resultat{
    for $g in distinct-values(//Book/@Genre)
    order by $g
    return(
        <Genre Namn="{$g}">{
            for $a in //Author[../@Genre=$g][not(@Name=preceding::Author/@Name and ../@Genre=preceding::Author/../@Genre)]
            let $n := $a/@Name
            (: where $a/../@Genre = $g :)
            order by $n
            return <Författare>{$n}</Författare>
        }
        </Genre>
    )
}