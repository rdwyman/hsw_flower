include <flower_generator.scad>;
include <hex_plug_library.scad>;

module make_flower_center(height = 15, stalk_thickness_ratio = 0.7, transition_height_ratio = 0.5) {
  union() {
    insert_with_plate();

    honeycomb_height = 8;

    scale([stalk_thickness_ratio, stalk_thickness_ratio, -height / honeycomb_height]) {
      hull() {
        make_flower(target_size=1);
      }
    }

    transition_ratio = (1 + stalk_thickness_ratio) / 2;

    hull() {
      scale([transition_ratio, transition_ratio, -transition_height_ratio]) {
        make_flower(target_size=1);
      }
    }
    translate([0, 0, -height]) {
      hull() {
        scale([transition_ratio, transition_ratio, transition_height_ratio]) {
          make_flower(target_size=1);
        }
      }
    }
    translate([0, 0, -honeycomb_height - height]) {
      make_flower(target_size=1);
    }
  }
}

make_flower_center();
