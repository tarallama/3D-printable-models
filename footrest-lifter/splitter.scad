use <design.scad>;

size = 200;
partA = false;

if(partA)
{
    intersection()
    {
        main();
        translate([-size,-50,-1]) cube(size * 1.2);
    }
}
else
{
    intersection()
    {
        main();
        translate([-size,190,-1]) cube(size * 1.2);
    }
}