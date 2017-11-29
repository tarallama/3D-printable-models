$fn = 100;
footrest_pole_radius = 13/2;
footrest_pole_length = 30;

module connector
(
    extra_width = 0,
    extra_depth = 0
)
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
                raise_height = 160,
                extra_width = extra_width,
                extra_depth = extra_depth
            );
        }

        //Drill out interior
        cylinder
        (
            h = footrest_pole_length + extra_depth,
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
    raise_height = 1,
    extra_width = 0,
    extra_depth = 0
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
                    footrest_pole_length + extra_depth
                ]
            );
        }
    }
}

module mainBody()
{
    connector
    (
        extra_width = 70,
        extra_depth = 50
    );
}

module main()
{
    rotate(a=[0,0,0])
    {
        mainBody();
    }
}

main();