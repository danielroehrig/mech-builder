$fn=25;
switch_cutout_size=14;
plate_height=1.5;
plate_width=350;
plate_depth=115;

/*
2D outline for just a switch
	type: (string) the model of switch, currently supports "PG1350" (Kailh Choc)
	center: (bool) whether to center the switch in the x and y axes
	tol: (number) tolerance (>0 recommended) if using this module to generate a plate
	w: width in u
	h: height in u
*/
module switchPlateFootprint(w = 1, h = 1) {
    switchDim = 14;
    if(w<2 && h<2){
        square(switchDim, false);
    }else if(w > h && w >= 2 && w < 3){
        fullLength = (0.825+6.75+1.525+7)*2;
//        translate( center ? [-fullLength/2, -switchDim/2] : [0,0] )
        union(){         
            translate([-1.525-6.75-0.825,6.285+0.23,0]) square([0.825+6.75+1.525+switchDim+0.825+6.75+1.525,2.785]);
            translate([-1.525-6.75,0.23,0]) square([6.75,3.23+2.785+6.285]);
            translate([-1.525-1.725-3.3,-1.2+0.23,0]) square([3.3, 1.2]);
            square(switchDim);
            translate([switchDim+1.525,0.23,0]) square([6.75,3.23+2.785+6.285]);
            translate([switchDim+1.525+1.725,-1.2+0.23,0]) square([3.3, 1.2]);
            translate([-1.525,4.7,0]) square([switchDim+1.525*2, 4]);
        }
    }
}

u = 14;
d = 2.525;

//x,y,w,h,
lays = [
	[1.5,0,1,1], [2.5,0,1,1], [3.5,0,1,1],
    [1,1,1.5,1], [2.5,1,1,1], [3.5,1,1,1],
    [0.75,2,1.75,1], [2.5,2,1,1], [3.5,2,1,1],
    [0.25,3,2,1], [2.5,3,1,1], [3.5,3,1,1],
];

for ( keyPos = [0:len(lays)-1]){
    translate([lays[keyPos][0]*19, -lays[keyPos][1]*19, 0])
    switchPlateFootprint(lays[keyPos][2], lays[keyPos][3]);
}