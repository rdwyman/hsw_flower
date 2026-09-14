import os
import stl

os.chdir(os.path.dirname(__file__))

stl_file = stl.mesh.Mesh.from_file("wall-honeycomb-106x89-fixed.stl")
stl_file.translate(-stl_file.min_)
stl_file.save("wall-honeycomb-106x89-fixed-translated.stl")
