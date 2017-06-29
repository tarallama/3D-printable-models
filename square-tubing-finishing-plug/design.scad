width = 45;
height = width;
depth = 15;

module mainBody() 
{
    //Main structural body
    cube
    (
        [
            width,
            height,
            depth
        ],
        center = false
    );
}

mainBody();