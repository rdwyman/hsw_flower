include <hex_plug_library.scad>;

DEFAULT_FLOWER_SIZE = 3;

module make_flower(tolerance = 0, inner_tolerance = 0, flower_size = DEFAULT_FLOWER_SIZE) {

  BASIS_VECTOR_A = [0, HEXAGON_WIDTH, 0];
  BASIS_VECTOR_B = [HEXAGON_WIDTH * sin(60), -HEXAGON_WIDTH * cos(60), 0];

  for (i = [0:2 * flower_size - 2]) {

    if (i < flower_size) {
      for (j = [0:flower_size + i - 1]) {
        translate([i * BASIS_VECTOR_A[0] + j * BASIS_VECTOR_B[0], i * BASIS_VECTOR_A[1] + j * BASIS_VECTOR_B[1], 0]) {
          insert_empty(tolerance=0, inner_tolerance=0);
        }
      }
    } else {
      for (j = [i - flower_size + 1:2 * flower_size - 2]) {
        translate([i * BASIS_VECTOR_A[0] + j * BASIS_VECTOR_B[0], i * BASIS_VECTOR_A[1] + j * BASIS_VECTOR_B[1], 0]) {
          insert_empty(tolerance=0, inner_tolerance=0);
        }
      }
    }
  }
}

make_flower(flower_size=3);

translate([100, 0, INSERT_TOTAL_HEIGHT]) {
  make_flower(flower_size=4);
}
