$fs = .1;
radius = 32/2;
height = 1;

module mainBody()
{
    //Main structural body
    hull()
    {
        cylinder
        (
            height,
            radius,
            radius,
            center = false,
            $fs = $fs
        );

        corner();
    }
}

module corner()
{
    //Round off the edge
    cornerRadius = 3;
    translate
    (
        [
            0,
            0,
            height
        ]
    )
    {
        rotate_extrude(convexity = 10)
        {
            difference()
            {
                translate
                (
                    [
                        radius-cornerRadius,
                        0,
                        0
                    ]
                )
                {
                    circle
                    (
                        r = cornerRadius,
                        center = false
                    );
                }

                width = cornerRadius * 2;
                translate
                (
                    [
                        radius-width,
                        -width,
                        0
                    ]
                )
                {
                    square
                    (
                        size = width,
                        center = false
                    );
                }
            }
        }
    }
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