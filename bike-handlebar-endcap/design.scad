$fs = .1;
radius = 32/2;
height = 4;

module mainBody()
{
    //Main structural body
    cylinder
    (
        height,
        radius,
        radius,
        center = false,
        $fs = $fs
    );
}

module connector()
{
    //What actually holds the part onto the handlebars
    connHeight = 2;
    connRadius = 25/2;
    translate
    (
        [
            0,
            0,
            -connHeight
        ]
    )
    {
        difference()
        {
            union()
            {
                //Basic body
                cylinder
                (
                    connHeight,
                    connRadius,
                    connRadius,
                    center = false,
                    $fs = $fs
                );

                //Friction grabber
                cylinder
                (
                    0.5,
                    connRadius+.5,
                    connRadius+.5,
                    center = false,
                    $fs = $fs
                );
            }

            //Inner cavity
            buffer = 1;
            translate
            (
                [
                    0,
                    0,
                    -buffer
                ]
            )
            {
                innerRadius = 21/2;
                cylinder
                (
                    connHeight+buffer,
                    innerRadius,
                    innerRadius,
                    center = false,
                    $fs = $fs
                );
            }
        }
    }
}

module main()
{
    rotate(a=[180,0,0])
    {
        mainBody();
        connector();
    }
}

main();