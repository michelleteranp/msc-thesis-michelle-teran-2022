# clean
rm -rf mashtriangle.err
rm -rf mashtriangle_results.txt

# activate conda and conda_envs
# run conda
conda activate conda_envs

# mash triangle
mash triangle $1

