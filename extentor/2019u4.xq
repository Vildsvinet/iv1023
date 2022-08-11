(:4 a):)

element Idrotter{
    for $t in distinct-values(//Utomhusplan/@typ)
    let $ak:=count(//Kommun[exists(./Utomhusplan[@typ=$t])])
    let $apt:=count(//Utomhusplan[@typ=$t])
    order by $t
    return element Idrott{
        attribute namn{$t},
        element AntalKommunerMedPlan{$ak},
        element AntalPlanerTotalt{$apt}
    }
}

4 b)

