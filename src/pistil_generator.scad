include <flower_generator.scad>;
include <hex_plug_library.scad>;

module hexagon_pyramid(height = 10, radius = 5) {
  pts = [
    height * [0, 0, 1],
    radius * [cos(60), sin(60), 0],
    radius * [cos(120), sin(120), 0],
    radius * [cos(180), sin(180), 0],
    radius * [cos(240), sin(240), 0],
    radius * [cos(300), sin(300), 0],
    radius * [cos(360), sin(360), 0],
  ];

  fcs = [
    [2, 1, 0],
    [3, 2, 0],
    [4, 3, 0],
    [5, 4, 0],
    [6, 5, 0],
    [1, 6, 0],
    [1, 2, 3, 4, 5, 6],
  ];

  polyhedron(pts, fcs);
}

module make_flower_center(height = 15, stalk_thickness_ratio = 0.3, transition_height_ratio = 0.5) {

  difference() {
    union() {
      insert_with_plate();

      honeycomb_height = 8;

      scale([stalk_thickness_ratio, stalk_thickness_ratio, -height / honeycomb_height]) {
        hull() {
          make_flower(target_size=1);
        }
      }

      transition_ratio = (1 + stalk_thickness_ratio) / 2;

      rotate([180, 0, 0]) {
        hexagon_pyramid(radius=INSERT_LIP_DIAMETER / 2, height);
      }

      translate([0, 0, -height]) {
        hexagon_pyramid(radius=af_to_diameter(HEX_SEPARATION / 2 + HEX_WALL_THICKNESS / 2), height);
      }
      translate([0, 0, -honeycomb_height - height]) {
        make_flower(target_size=1);
      }
    }
    translate([0, 0, -height]) {
      hexagon_pyramid(radius=af_to_diameter(HEX_SEPARATION / 2), height);
    }
  }
}

make_flower_center();

TODO: Go back about 2 commits and bring that code back in as a different type of pistil
