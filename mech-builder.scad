$fn=25;
plate_height=1.5;
plate_width=350;
plate_depth=115;
uSize=19;
switchDim = 14;

/*
2D outline for just a switch
	type: (string) the model of switch, currently supports "PG1350" (Kailh Choc)
	center: (bool) whether to center the switch in the x and y axes
	tol: (number) tolerance (>0 recommended) if using this module to generate a plate
	w: width in u
	h: height in u
*/
module switchPlateFootprint(w = 1, h = 1, tol = 0.05) {
    if(w<2 && h<2){
        square(switchDim+tol, false);
    }else if(w > h && w >= 2 && w < 3){
        fullLength = (0.825+6.75+1.525+(switchDim/2))*2;
        union(){         
            translate([-1.525-6.75-0.825,6.285+0.23,0]) square([fullLength,2.785]);
            translate([-1.525-6.75,0.23,0]) square([6.75,3.23+2.785+6.285]);
            translate([-1.525-1.725-3.3,-1.2+0.23,0]) square([3.3, 1.2]);
            square(switchDim);
            translate([switchDim+1.525,0.23,0]) square([6.75,3.23+2.785+6.285]);
            translate([switchDim+1.525+1.725,-1.2+0.23,0]) square([3.3, 1.2]);
            translate([-1.525,4.7,0]) square([switchDim+1.525*2, 4]);
        }
    }else if(w > h && w >= 6 && w <= 7){
        fullLength = (2*(0.825+6.75+1.525)+switchDim+((w-2)*uSize));
        union(){
            translate([-1.525-6.75-0.825,6.285+0.23,0]) square([fullLength,2.785]);
            translate([-1.525-6.75,0.23,0]) square([6.75,3.23+2.785+6.285]);
            translate([(-1.525-6.75)*2+fullLength,0.23,0]) square([6.75,3.23+2.785+6.285]);
            translate([-1.525-1.725-3.3,-1.2+0.23,0]) square([3.3, 1.2]);
            translate([2*(-1.525-1.725-3.3)+fullLength-1.725,-1.2+0.23,0]) square([3.3, 1.2]);
            #translate([-1.525-6.75-0.825+fullLength/2-switchDim/2, 0, 0]) square([switchDim,switchDim]);
        }
    }else{
        echo("What kind of weird keysize is THAT?!");
    }
}

module copy_mirror(vec=[1,0,0], offset=[0,0,0]){
    children();
    translate(offset) mirror(vec) children();
}
u = 14;
d = 2.525;

//x,y,w,h,
lays = [
	[1.5,0,1,1], [2.5,0,1,1], [3.5,0,1,1],[4.5,0,1,1],[5.5,0,1,1],[6.5,0,1,1],[7.5,0,1,1],[8.5,0,1,1],[9.5,0,1,1],[10.5,0,1,1],[11.5,0,1,1],[12.5,0,1,1],[13.5,0,1,1],[13.5,0,1,1],[14.5,0,2,1],
    [1,1,1.5,1], [2.5,1,1,1], [3.5,1,1,1],[4.5,1,1,1],[5.5,1,1,1],[6.5,1,1,1],[7.5,1,1,1],[8.5,1,1,1],[9.5,1,1,1],[10.5,1,1,1],[11.5,1,1,1],[12.5,1,1,1],[13.5,1,1,1],[14.5,1,1.5,1],
    [0.75,2,1.75,1], [2.5,2,1,1], [3.5,2,1,1],[4.5,2,1,1],[5.5,2,1,1],[6.5,2,1,1],[7.5,2,1,1],[8.5,2,1,1],[9.5,2,1,1],[10.5,2,1,1],[11.5,2,1,1],[12.5,2,1,1],[13.5,2,2.25,1],
    [0.25,3,2,1], [2.5,3,1,1], [3.5,3,1,1],[4.5,3,1,1],[5.5,3,1,1],[6.5,3,1,1],[7.5,3,1,1],[8.5,3,1,1],[9.5,3,1,1],[10.5,3,1,1],[11.5,3,1,1],[12.5,3,2.75,1],
    [0,4,1.25,1], [1.25,4,1.25,1],[3.5,4,1,1],[4.5,4,6,1],[10.5,4,1,1],[12.5,4,1.25,1],[13.75,4,1.25,1],
];

for ( keyPos = [0:len(lays)-1]){
    xpos = lays[keyPos][0]*uSize;
    widthInU = lays[keyPos][2];
    heightInU = lays[keyPos][3];
    if(widthInU<3){   
        translate([xpos+((widthInU*uSize)-switchDim)/2, -lays[keyPos][1]*19, 0]) {
            switchPlateFootprint(widthInU, heightInU);
        }
    }else if(widthInU>=6) {
        translate([xpos+((widthInU*uSize)-switchDim)/2-(2*uSize), -lays[keyPos][1]*19, 0]) {
            switchPlateFootprint(widthInU, heightInU);
        }
    }
}