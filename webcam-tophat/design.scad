$fs = .1;
radius = 45/2;
height = 60;
wallThickness = 3;

module positiveVolumes()
{
   //Brim
    brimExtraRadius = 3;
    cylinder
    (
        wallThickness,
        radius + brimExtraRadius,
        radius + brimExtraRadius,
        center = false,
        $fs = $fs
    );

    //Main body of hat
    cylinder
    (
        height,
        radius,
        radius,
        center = false,
        $fs = $fs
    );
}

module hat()
{
    difference()
    {
        positiveVolumes();

        //remove interior of hat
        translate
        (
            [
                0,
                0,
                -1
            ]
        )
        {
            cylinder
            (
                height - wallThickness + 1,
                radius - wallThickness,
                radius - wallThickness,
                center = false,
                $fs = $fs
            );
        }
    }
}

module main()
{
    rotate(a=[0,0,0])
    {
        hat();
    }
}

main();