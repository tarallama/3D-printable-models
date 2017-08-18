$fn = 100;
radius = 25;
structureHeight = 7;
detailHeight = 2;

module structure()
{
    cylinder
    (
        structureHeight,
        radius,
        radius,
        center = false
    );
}

module coin(detailHeight)
{
    rimThickness = 2;
    difference()
    {
        structure();
 
        translate
        (
            [
                0,
                0,
                structureHeight - detailHeight
            ]
        )
        {
            cylinder
            (
                detailHeight + 1,
                radius - rimThickness,
                radius - rimThickness,
                center = false
            );
        }
    }
}

module 3dtext(string, detailHeight)
{
    translate
    (
        [
            0,
            0,
            structureHeight - detailHeight
        ]
    )
    {
        linear_extrude(detailHeight)
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
        coin(detailHeight);
        3dtext("TEST", detailHeight);
    }
}

main();
