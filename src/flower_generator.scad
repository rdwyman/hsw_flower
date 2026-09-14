include <hex_plug_library.scad>;

DEFAULT_FLOWER_SIZE = 3;

module make_flower(tolerance = 0, inner_tolerance = 0, flower_size = DEFAULT_FLOWER_SIZE) {
  // TODO: Add half edge border around the flower so the outer edges are not thinner than inner edges.

  BASIS_VECTOR_A = [0, HEX_SEPARATION, 0];
  BASIS_VECTOR_B = [HEX_SEPARATION * sin(60), -HEX_SEPARATION * cos(60), 0];

  for (i = [0:2 * flower_size - 2]) {

    if (i < flower_size) {
      for (j = [0:flower_size + i - 1]) {
        translate([i * BASIS_VECTOR_A[0] + j * BASIS_VECTOR_B[0], i * BASIS_VECTOR_A[1] + j * BASIS_VECTOR_B[1], 0]) {
          make_cell();
        }
      }
    } else {
      for (j = [i - flower_size + 1:2 * flower_size - 2]) {
        translate([i * BASIS_VECTOR_A[0] + j * BASIS_VECTOR_B[0], i * BASIS_VECTOR_A[1] + j * BASIS_VECTOR_B[1], 0]) {
          make_cell();
        }
      }
    }
  }
}

module make_cell() {

  TRIM_DISTANCE = HEX_SEPARATION / 2;
  BIG_NUMBER = 1000;

  difference() {
    translate([-af_to_diameter(TRIM_DISTANCE), -TRIM_DISTANCE, 0]) {
      import("../data/wall-honeycomb-106x89-fixed-normalized.stl");
    }

    for (i = [0:5]) {
      rotate([0, 0, i * 60]) {
        translate([-BIG_NUMBER / 2, TRIM_DISTANCE, -BIG_NUMBER / 2]) {
          cube([BIG_NUMBER, BIG_NUMBER, BIG_NUMBER]);
        }
      }
    }
  }
}

make_flower();
