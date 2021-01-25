git clone https://github.com/pytorch/pytorch
cd pytorch 
git checkout tags/v1.5.0
git submodule update --init --recursive

sudo apt install libopenblas-dev libblas-dev m4 cmake cython python3-dev python3-yaml python3-setuptools libatomic-ops-dev
pip install pyyaml
sed -i '/set(CMAKE_EXPORT_COMPILE_COMMANDS ON)/a set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} -latomic)' CMakeLists.txt
export NO_CUDA=1
export NO_DISTRIBUTED=1
export NO_MKLDNN=1
export BUILD_TEST=0
export MAX_JOBS=4
export NO_NNPACK=1
export NO_QNNPACK=1
python setup.py build
setup.py bdist_wheel
