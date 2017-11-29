$fn = 100;
footrest_pole_radius = 13/2;
footrest_pole_length = 20; //360;

module connector()
{
    gripper_width = 5;
    total_width = (footrest_pole_radius + gripper_width) * 2;

    difference()
    {
        cylinder
        (
            h = footrest_pole_length,
            r = footrest_pole_radius + (gripper_width / 2),
            center = false
        );

        cylinder
        (
            h = footrest_pole_length,
            r = footrest_pole_radius,
            center = false
        );

        translate
        (
            [
                footrest_pole_radius - footrest_pole_radius / 6,
                -total_width / 2,
                0
            ]
        )
        {
            cube
            (
                size =
                [
                    total_width,
                    total_width,
                    footrest_pole_length
                ]
            );
        }
    }
}

module mainBody()
{
    connector();
}

module main()
{
    rotate(a=[0,0,0])
    {
        mainBody();
    }
}

main();