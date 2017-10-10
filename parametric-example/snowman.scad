$fn = 100;

module snowman(size)
{
    sphere(size);

    translate([0,0,size])
    {
        sphere(size * 2/3);
    }

    translate([0,0,size*2])
    {
        sphere(size / 2);
    }
}






























//Content below this line cuts a flat bottom into the snowman
// which allows for easy 3d printing

difference()
{
    size = 20;
    snowman(size = size);

    translate([-size,-size,-size*2.5])
    {
        cube(size * 2);
    }
}