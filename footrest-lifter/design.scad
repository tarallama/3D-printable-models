$fs = .1;
footrest_pole_radius = 13/2;
footrest_pole_length = 1; //360;

module mock()
{
    %cylinder
    (
        h = footrest_pole_length,
        r = footrest_pole_radius,
        center = false
    );
}

module mainBody()
{
    gripper_radius = 2;
    translate
    (
        [
            footrest_pole_radius + gripper_radius,
            0,
            0
        ]
    )
    {
        cylinder
        (
            h = footrest_pole_length,
            r = gripper_radius,
            center = false
        );
    }
}

module main()
{
    rotate(a=[0,0,0])
    {
        mainBody();
        mock();
    }
}

main();