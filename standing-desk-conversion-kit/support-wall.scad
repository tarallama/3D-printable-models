use <design.scad>;
include <lib/puzzlecutlib.scad>;

module main()
{
    pillar_width_separation = 260;
    pillar_depth_separation = 370;
    extra_width = 40;
    extra_depth = 40;
    raise_height = 140;
    bridge_diameter = 17;

    translate([0,-145,0])
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
                pillar_depth_separation = pillar_depth_separation,
                bridge_diameter = bridge_diameter
            );
        }
    }
}

module cutInTwo()
{
	translate([0,-cutSize * 2,0])
		xMaleCut() main();

	translate([0,0,0])
		xFemaleCut() main();
}

stampSize = [500,500,500];
cutSize = 17;
xCut1 = [-150, -70];
kerf = -1.3;

module kerf_test()
{
    intersection()
    {
        cutInTwo();
        translate([-85,-40,0]) cube([30,60,15]);
    }
}

module hole_test()
{
    intersection()
    {
        main();
        translate([-68,18,0]) cube([25,25,25]);
    }
}

cutInTwo();