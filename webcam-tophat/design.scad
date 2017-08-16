$fn = 100;
radius = 43/2;
height = 60;
wallThickness = 3;
brimExtraRadius = 14;

module positiveVolumes()
{
   //Brim
    cylinder
    (
        wallThickness,
        radius + brimExtraRadius + wallThickness,
        radius + brimExtraRadius + wallThickness,
        center = false
    );

    //Main body of hat
    cylinder
    (
        height,
        radius + wallThickness,
        radius + wallThickness,
        center = false
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
                radius,
                radius,
                center = false
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
