$fs = .25;
radius = 15/2;
height = 25;

difference()
{
    cylinder(
        height,
        radius,
        radius,
        center = false,
        $fs = $fs
    );

    //Chop off half the cylinder
    translate(
        [
            -radius,
            0,
            -1
        ]
        )
    {
        cube(
            [
                radius*2,
                radius*2,
                height+2
            ],
            center = false
        );
    }
    
    //Slit
    width = 1.5;
    translate(
        [
            -width/2,
            -radius,
            -1
        ]
        )
    {
        cube(
            [
                width,
                radius+1,
                radius+2
            ],
            center = false
        );
    }
}