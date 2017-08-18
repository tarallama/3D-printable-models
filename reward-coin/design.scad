$fn = 100;
radius = 25;
height = 7;

module coin(rimHeight)
{
    rimThickness = 2;
    difference()
    {
        cylinder
        (
            height,
            radius,
            radius,
            center = false
        );

        translate
        (
            [
                0,
                0,
                height - rimHeight
            ]
        )
        {
            cylinder
            (
                rimHeight + 1,
                radius - rimThickness,
                radius - rimThickness,
                center = false
            );
        }
    }
}

module 3dtext(string, rimHeight)
{
    translate
    (
        [
            0,
            0,
            height - rimHeight
        ]
    )
    {
        linear_extrude(rimHeight)
        {
            text(
                string,
                font="Liberation:style=Bold",
                valign = "center",
                halign = "center"
            );
        }
    }
}

module main()
{
    rotate(a=[0,0,0])
    {
        rimHeight = 2;
        coin(rimHeight);
        3dtext("TEST", rimHeight);
    }
}

main();