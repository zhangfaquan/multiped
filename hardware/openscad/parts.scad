$fn=45;

module 4_40_hole(len=20, cen=true){
    // should be like 2.8448 mm
    cylinder(len,d=3,center=cen);
}

module bottomHoles(x=0,y=0,z=0){
    center = true;
    height = 15;
    hole = 2.15; // 4.1 mm diameter
    hdist = 6; // 6 mm center to center distance
    vdist = 18; // 18 mm center to center distance
    translate([x-6,y,z]){
        cylinder(height,hole,hole, center);
        translate([hdist,0,0]) cylinder(height,hole,hole, center);
        translate([2*hdist,0,0]) cylinder(height,hole,hole, center);
    }
}

module bodyHoles(x=0,y=0,z=0){
    center = true;
    height = 15;
    hole = 2.15; // 4.1 mm diameter
    hdist = 6; // 6 mm center to center distance
    vdist = 6; // 18 mm center to center distance
    translate([x,y-3.5,z]){
//        translate([0,9,0]) cube([height,10,14], center);
        bottomHoles(0, vdist+18, 0);
        bottomHoles(0, vdist+12, 0);
        bottomHoles(0, vdist+6, 0);
        bottomHoles(0, vdist, 0);
        bottomHoles(0, 0, 0);
    }
}

module hornHoles(x=0, y=0, z=0, angle=0){
    height = 15;
    hole = 2.15; // 4.1 mm diameter
    dist = 6; // 6 mm center to center distance
    rotate([0,0,angle]){
        center = true;
        translate([x-6,y,z]){
            cylinder(height, 2, 2, center);
            translate([dist,0,0]){
                cylinder(height, 2, 2, center);
                translate([dist,0,0]){
                    cylinder(height, 2, 2, center);
                }
            }
            translate([dist, dist, 0]) {
                cylinder(height, 2, 2, center);
            }
            translate([dist, -dist, 0]) {
                cylinder(height, 2, 2, center);
            }
        }
    }
}

//module bar(length){
//    width = 20;
//    height = 2;
//    translate([0, width/2,0]) {
//        cylinder(height, width/2, width/2, false);
//    }
//    //translate([width/2,0,0]){
//        cube([length-width,width,height], false);
//        translate([length-width, width/2, 0]){
//            cylinder(height, width/2, width/2, false);
//        }
//}

module pulley(height=3){
    /*
    This creates a pulley to offset a side w/o a horn.
    */
    difference(){
        cylinder(height,9,9, true);
        hornHoles(0,0,0,0);
    }
}

//module bar2(length){
//    /*
//    This creates a bar that looks like a popsicle stick.
//    */
//    hull(){
//        translate([0,length,0]) cylinder(2,10,10,false);
//        cylinder(2,10,10,false);
//    }
//}


//module femur_horn2horn(length){
//    difference(){
//        bar2(length);
//        hornHoles(0,0,0, 0);
//        hornHoles(0,length,0, 0);
//    }
//}
//
//module femur_side2side(length){
//    union(){
//        difference(){
//            bar2(length);
//            hornHoles(0,0,0, 0);
//            hornHoles(0,length,0, 0);
//        }
//        translate([0,0,3.5]) pulley();
//        translate([0,length,3.5]) pulley();
//    }
//}
//
//module sidePlate(length=18){
//    difference(){
//        bar2(length);
//        bodyHoles(0,0,0);
//    }
//}

//module foot(length){
//    base = 7.5;
//    end = 2.5;
//    color("CornflowerBlue", 1) {
//        cylinder(length, 7.5, 2.5, false);
//        translate([0,0,length]) sphere(end);
//    }
//}
//
//module foot2(length){
//    translate([0,6,0]) rib(-1, length);
//    translate([0,-6,0]) rib(1, length);
//    translate([length-2,0,0]) cylinder(5,2,2);
//}

//module foot3(length){
//    difference(){
//        union(){
//    translate([0,-34/2,0]) cube([20, 34, 2], false);
//    linear_extrude(height=4, center=false)
//        polygon([[0,-6],[length,-2],[length,2],[0,6]]);
//    translate([length,0,2]) sphere(2);
//        }
////    translate([9,-9,0]) bodyHoles();
//        translate([10,-12,0]){
//            bottomHoles();
//            bottomHoles(0,24,0);
//        }
//    }
//}

/*module coxa(){
    cube([1,1,1], true);
}

module rib(side, length){
    angle = side*atan2(4,length);
    echo(angle);
    rotate([90,0,angle]){
        linear_extrude(height=2, center=true) polygon([[0,0],[length,0],[length,4],[0,4]]);
    }
}*/

//module lplate(){
//    // facing the wrong way!
//    sidePlate(33-9);
//    translate([0,33-9,5]) {
//        difference(){
//            cube([20,2,10], true);
//            rotate([90,0,0]) bottomHoles();
//        }
//    }
//}


/*module tibia(length=50){
    lplate();
}*/

module u_frame(length=18){
    /*
    Makes a u frame connected to the horn. The bottom of the horn can mount the back or
    side of a servo motor with a hole to pass the cable through.

    length - measured from the bottom of the u to the center horn hole (piviot point) in mm
    */
    fillets = true;
    difference() {
            union(){
                cube([20,34,2], true);
                translate([0,32/2,length/2]){
                    cube([20,2,length+2], true);
                    translate([0,0,length/2]) rotate([90,0,0]) cylinder(2,10,10, true);
                }
                translate([0,-32/2,length/2]){
                    cube([20,2,length+2], true);
                    translate([0,0,length/2]) rotate([90,0,0]) cylinder(2,10,10, true);
                }
                rr=2;
                translate([0,32/2-2,length]) rotate([90,0,0]) pulley();
                if(fillets){
                    render(convexity=2) difference(){
                        translate([0,32/2-1,1]) rotate([0,90,0]) cylinder(20,rr,rr, true);
                        translate([0,32/2-3,3]) rotate([0,90,0]) cylinder(20,rr,rr, true);
                    }
                    render(convexity=2) difference(){
                        translate([0,-32/2+1,1]) rotate([0,90,0]) cylinder(20,rr,rr, true);
                        translate([0,-32/2+3,3]) rotate([0,90,0]) cylinder(20,rr,rr, true);
                    }
                }
            }
        translate([0,34/2,length]) rotate([90,0,0]) hornHoles();
        translate([0,-34/2,length]) rotate([90,0,0]) hornHoles();
        translate([0,-34/4,0]) bodyHoles();
    }
}

module edgeHoles(x=0, y=0, z=0, angle=0){
    height = 15;
    hole = 2.15; // 4.1 mm diameter
    dist = 6; // 6 mm center to center distance
    rotate([0,0,angle]){
        center = true;
        translate([x-6,y,z]){
            cylinder(height, 2, 2, center);
            translate([dist,0,0]){
                cylinder(height, 2, 2, center);
                translate([dist,0,0]){
                    cylinder(height, 2, 2, center);
                }
            }
//            translate([dist, dist, 0]) {
//                cylinder(height, 2, 2, center);
//            }
//            translate([dist, -dist, 0]) {
//                cylinder(height, 2, 2, center);
//            }
        }
    }
}

module strut(length, width, height){
    points2 = [ [10,10,0],[10,-10,0],[-10,-10,0],[-10,10,0], // the four points at base
           [0,0,10]  ];
    points = [
        [0,0,0],
        [width,0,0],
        [width,length,0],
        [0,length,0],
        [0,length,height],
        [width,length,height]
    ];
    faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]];
    polyhedron(points, faces);
}

module main_plate(dia=65, hole=20){
    /*
    makes the base plate that the legs are mounted to
    */
    bar_th = 4;
    offset = 5;
    difference(){
        // build base plate
        union(){
            cylinder(2, d=dia, center=false);
            l = dia/2;
            w = 4;
            //rotate([0,0,45]) translate([-w/2,-l,0]) strut(l,w,10);
            //translate([0,0,bar_th/2]) rotate([0,0,45]) cube([dia,bar_th,bar_th], center=true);
            //translate([0,0,bar_th/2]) rotate([0,0,45]) cube([bar_th,dia,bar_th], center=true);
            // mount point or feet
            //mw = 10;
            //ml = 30;
            //dist = 20;
            //translate([-ml/2,-mw/4+dist,2]) cube([ml,mw/2,mw], center=false);
            //translate([-ml/2,-mw/4-dist,2]) cube([ml,mw/2,mw], center=false);
        }
        // cut out mount points
        translate([dia/2-offset,0,0]) edgeHoles(angle=90);
        translate([-dia/2+offset,0,0]) edgeHoles(angle=90);
        translate([0, dia/2-offset,0]) edgeHoles();
        translate([0, -dia/2+offset,0]) edgeHoles();
        // cut out center hole for wires
        cylinder(20, d=hole, center=true);
        // 4-40 holes
        rotate([0,0,45]) translate([dia/2-offset,0,0]) 4_40_hole();
        rotate([0,0,135]) translate([dia/2-offset,0,0]) 4_40_hole();
        rotate([0,0,225]) translate([dia/2-offset,0,0]) 4_40_hole();
        rotate([0,0,315]) translate([dia/2-offset,0,0]) 4_40_hole();
    }
}

module base_plate(dia=65){
    union(){
        main_plate(dia);
        union(){ 
            difference(){
                cylinder(10, d=dia/2, center=false);
                mw = 10;
                ml = 30;
                dist = 15;
                translate([-ml/2,-mw/2+dist,2]) cube([ml,mw,mw], center=false);
                translate([-ml/2,-mw/2-dist,2]) cube([ml,mw,mw], center=false);
            }
            offset = dia/2-5;
            rotate([0,0,45]) translate([offset,0,0]) cylinder(10, d=10, center=false);
            rotate([0,0,45]) translate([-offset,0,0]) cylinder(10, d=10, center=false);
            rotate([0,0,45]) translate([0,offset,0]) cylinder(10, d=10, center=false);
            rotate([0,0,45]) translate([0,-offset,0]) cylinder(10, d=10, center=false);
        }
    }
}

module neck(outer=40, inner=25, len=70){
    difference(){
        union(){
            ch = outer/3;
            cylinder(ch,r1=outer/2, r2=inner/2, center=false);
            translate([0,0,len-ch]) cylinder(ch,r1=inner/2, r2=outer/2, center=false);
            cylinder(len, d=inner, center=false);
        }
        cylinder(len*5, d=20, center=true);
    }
}

module top_plate(dia=65){
    union(){
        main_plate(dia);
        neck();
        /*
        difference(){
            cylinder(10, d=dia/2, center=false);
            cylinder(200, d=dia/4, center=true);
        }
        */
    }
        
}

use <pi-zero/files/PiZero_1.2.scad>;

color("SkyBlue", 1) {
    //pulley();
	//u_frame(25);
    main_plate();
    //base_plate();
    //top_plate();
    //neck();
    //translate([0,0,10]) PiZeroBody();
}
