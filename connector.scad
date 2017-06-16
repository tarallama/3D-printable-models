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
}