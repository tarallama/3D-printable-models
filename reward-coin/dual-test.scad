use <coin-library.scad>;

module testBothStyles()
{
    radius = 30;
    rotate(a=[0,0,0])
    {
        coin
        (
            message = "LEMON",
            positiveText = true,
            radius = radius
        );
    }

    translate
    (
        [
            radius * 2 + radius / 2,
            0,
            0
        ]
    )
    {
        coin
        (
            message = "LIME",
            positiveText = false,
            radius = radius
        );
    }
}

testBothStyles();