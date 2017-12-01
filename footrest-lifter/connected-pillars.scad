use <design.scad>;

module main()
{
    pillar_width_separation = 260;
    pillar_depth_separation = 370;
    extra_width = 60;
    extra_depth = 40;
    raise_height = 140;

    rotate([0,90,0])
    {
        difference()
        {
            two_connected_pillars
            (
                pillar_width_separation = pillar_width_separation,
                pillar_depth_separation = pillar_depth_separation,
                extra_width = extra_width,
                extra_depth = extra_depth,
                raise_height = raise_height
            );

            all_bridge_connectors
            (
                pillar_width_separation = pillar_width_separation,
                raise_height = raise_height,
                pillar_depth_separation = pillar_depth_separation
            );
        }
    }
}

main();