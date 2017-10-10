$fn = 100;

module sphereman(size)
{
    sphere(size);

    translate([0,0,size])
    {
        sphere(size * 2/3);
    }

    translate([0,0,size*2])
    {
        sphere(size / 2);
    }
}

module cubeman(size)
{
    translate
    (
        [
            size * 2,
            0,
            0
        ]
    )
    {
        cube(size);

        secondSize = size * 2/3;
        secondXYOffset = size / 2 - secondSize / 2;
        translate([secondXYOffset,secondXYOffset,size])
        {
            cube(secondSize);
        }

        thirdSize = size / 2;
        thirdXYOffset = size / 2 - thirdSize / 2;
        translate([thirdXYOffset,thirdXYOffset,size+secondSize])
        {
            cube(thirdSize);
        }
    }
}

size = 20;
sphereman(size = size);
cubeman(size = size);