include <scad-utils/morphology.scad>

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
        switchPlacer = (-1.525-6.75-0.825+fullLength/2-switchDim/2);
        union(){
            translate([-1.525-6.75-0.825-switchPlacer,6.285+0.23,0]) square([fullLength,2.785]);
            translate([-1.525-6.75-switchPlacer,0.23,0]) square([6.75,3.23+2.785+6.285]);
            translate([(-1.525-6.75)*2+fullLength-switchPlacer,0.23,0]) square([6.75,3.23+2.785+6.285]);
            translate([-1.525-1.725-3.3-switchPlacer,-1.2+0.23,0]) square([3.3, 1.2]);
            translate([2*(-1.525-1.725-3.3)+fullLength-1.725-switchPlacer,-1.2+0.23,0]) square([3.3, 1.2]);
            translate([0, 0, 0]) square([switchDim,switchDim]);
        }
    }else{
        echo("What kind of weird keysize is THAT?!");
    }
}

//x,y,w,h,
lays = [
	[1.5,0,1,1], [2.5,0,1,1], [3.5,0,1,1],[4.5,0,1,1],[5.5,0,1,1],[6.5,0,1,1],[7.5,0,1,1],[8.5,0,1,1],[9.5,0,1,1],[10.5,0,1,1],[11.5,0,1,1],[12.5,0,1,1],[13.5,0,1,1],[13.5,0,1,1],[14.5,0,2,1],
    [1,1,1.5,1], [2.5,1,1,1], [3.5,1,1,1],[4.5,1,1,1],[5.5,1,1,1],[6.5,1,1,1],[7.5,1,1,1],[8.5,1,1,1],[9.5,1,1,1],[10.5,1,1,1],[11.5,1,1,1],[12.5,1,1,1],[13.5,1,1,1],[14.5,1,1.5,1],
    [0.75,2,1.75,1], [2.5,2,1,1], [3.5,2,1,1],[4.5,2,1,1],[5.5,2,1,1],[6.5,2,1,1],[7.5,2,1,1],[8.5,2,1,1],[9.5,2,1,1],[10.5,2,1,1],[11.5,2,1,1],[12.5,2,1,1],[13.5,2,2.25,1],
    [0.25,3,2,1], [2.5,3,1,1], [3.5,3,1,1],[4.5,3,1,1],[5.5,3,1,1],[6.5,3,1,1],[7.5,3,1,1],[8.5,3,1,1],[9.5,3,1,1],[10.5,3,1,1],[11.5,3,1,1],[12.5,3,2.75,1],
    [0,4,1.25,1], [1.25,4,1.25,1],[3.5,4,1,1],[4.5,4,6,1],[10.5,4,1,1],[12.5,4,1.25,1],[13.75,4,1.25,1],
];

//intersection(){
//    rectangular_plate(lays, widthPadding = 3, heightPadding = 3, rounding = 5);
//    cube([202, 200, 5]);
//}

//intersection(){
//    rectangular_plate(lays, widthPadding = 3, heightPadding = 3, rounding = 5);
//    translate([202,0,0]) cube([202, 200, 5]);
//}
echo(maxHeight(lays));
echo(maxWidth(lays));

rectangular_plate(lays, widthPadding = 3, heightPadding = 3, rounding = 5);

module rectangular_plate(layout, widthPadding = 0, heightPadding = 0, rounding = 0) {
    linear_extrude(height=1.5){
        difference(){
            translate([0,0,0]) rounding(r=rounding) square([maxWidth(lays)+widthPadding*2,maxHeight(lays)+heightPadding*2], center=false);
            translate([widthPadding, heightPadding, 0])
            layout(layout);
        }
    }
}

module layout(lays){
    translate([0,maxHeight(lays),0])
    for ( keyPos = [0:len(lays)-1]){
        widthInU = lays[keyPos][2];
        heightInU = lays[keyPos][3];
        xpos = lays[keyPos][0]*uSize+((widthInU*uSize)-switchDim)/2;
        ypos = (lays[keyPos][1]+1)*uSize;

        if(widthInU<3){   
            translate([xpos, -ypos+(uSize-switchDim)/2, 0]) {
                switchPlateFootprint(widthInU, heightInU);
            }
        }else if(widthInU>=6) {
            translate([xpos, -ypos+(uSize-switchDim)/2, 0]) {
                switchPlateFootprint(widthInU, heightInU);
            }
        }
    }
}

function maxHeight(layout, i=0) = (i < len(layout)-1) ? max((layout[i][1]+layout[i][3])*uSize, maxHeight(layout, i+1)) : (layout[i][1]+layout[i][3])*uSize;

function maxWidth(layout, i=0) = (i < len(layout)-1) ? max((layout[i][0]+layout[i][2])*uSize, maxWidth(layout, i+1)) : (layout[i][0]+layout[i][2])*uSize;