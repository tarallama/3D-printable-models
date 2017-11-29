$fn = 100;
footrest_pole_radius = 13/2;
footrest_pole_length = 20;

module connector()
{
    gripper_width = 6;
    total_width = footrest_pole_radius * 2 + gripper_width;
    
    difference()
    {
        union()
        {
            //Main structural sidewall
            cylinder
            (
                h = footrest_pole_length,
                r = footrest_pole_radius + (gripper_width / 2),
                center = false
            );

            lifter
            (
                total_width = total_width,
                raise_height = 160
            );
        }

        //Drill out interior
        cylinder
        (
            h = footrest_pole_length,
            r = footrest_pole_radius,
            center = false
        );

        //Create opening for intallation
        translate
        (
            [
                footrest_pole_radius - (5 / 12) * footrest_pole_radius,
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

module lifter
(
    total_width = 1,
    raise_height = 1
)
{
    hull()
    {
        //Vertical structure
        translate
        (
            [
                -footrest_pole_length - raise_height,
                -total_width / 2,
                0
            ]
        )
        {
            cube
            (
                [
                    footrest_pole_length + raise_height,
                    total_width,
                    footrest_pole_length
                ]
            );
        }

        //Stabilization foot
        extra_width = 40;
        extra_height = 20;
        translate
        (
            [
                -footrest_pole_length - raise_height,
                - (total_width + extra_width) / 2,
                0
            ]
        )
        {
            cube
            (
                [
                    1,
                    total_width + extra_width,
                    footrest_pole_length + extra_height
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