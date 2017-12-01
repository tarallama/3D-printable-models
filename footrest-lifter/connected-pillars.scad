use <design.scad>;

module main()
{
    rotate([0,90,0])
    {
        two_connected_pillars
        (
            pillar_width_separation = 260,
            pillar_depth_separation = 370,
            extra_width = 60,
            extra_depth = 40,
            raise_height = 140
        );
    }
}

main();