use <mech-builder.scad>
case_wall_width = 3;
case_height = 10;
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

case_bottom(lays);

module case_bottom(layout) {
    width_padding = 3;
    height_padding = 3;
    translate([case_wall_width, case_wall_width, case_height])
    color("Cyan", 0.8) rectangular_plate(lays, widthPadding = width_padding, heightPadding = height_padding, rounding = 0);
    cube([maxWidth(layout)+(case_wall_width+width_padding)*2, maxHeight(layout)+(case_wall_width+height_padding)*2, case_height]);
}
