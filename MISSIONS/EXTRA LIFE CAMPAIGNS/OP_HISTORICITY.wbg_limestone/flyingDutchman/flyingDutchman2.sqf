ghostPos1 = getPosASL ghostShipStartPos;
ghostPos2 = ghostPos1 vectorAdd [0, 0.08, 0];

ghostPos3 = getPosASL ghostShipStartPos2;
ghostPos4 = ghostPos3 vectorAdd [0, 0.08, 0];

ghostPos5 = getPosASL ghostShipStartPos3;
ghostPos6 = ghostPos5 vectorAdd [0, 0.08, 0];


startTheShips = {
    Motherfucking setPosASL (getPosASL ghostShipStartPos);
    Gilbert setPosASL (getPosASL ghostShipStartPos2);
    Scantlebury setPosASL (getPosASL ghostShipStartPos3);

    onEachFrame
    {
        if (!alive Motherfucking && !alive Gilbert && !alive Scantlebury) then
        {
            onEachFrame {};
            //bossfight won
        };
        ghostPos1 = ghostPos2;
        ghostPos2 = ghostPos2 vectorAdd [0,0.08,0];
        Motherfucking setVelocityTransformation [
            ghostPos1,
            ghostPos2,
            [0,0,0],
            [0,0,0],
            [0,1,0],
            [0,1,0],
            [0,0,1],
            [0,0,1],
            moveTime Motherfucking
        ];

        ghostPos3 = ghostPos4;
        ghostPos4 = ghostPos4 vectorAdd [0,0.08,0];
        Gilbert setVelocityTransformation [
            ghostPos3,
            ghostPos4,
            [0,0,0],
            [0,0,0],
            [0,1,0],
            [0,1,0],
            [0,0,1],
            [0,0,1],
            moveTime Gilbert
        ];

        ghostPos5 = ghostPos6;
        ghostPos6 = ghostPos6 vectorAdd [0,0.08,0];
        Scantlebury setVelocityTransformation [
            ghostPos5,
            ghostPos6,
            [0,0,0],
            [0,0,0],
            [0,1,0],
            [0,1,0],
            [0,0,1],
            [0,0,1],
            moveTime Scantlebury
        ];
    };
};


