echo "****************************** Installing MoveIt! ******************************"

mkdir -p ~/rethink_ws/src
cd ~/rethink_ws/src && catkin_init_workspace
cd ~/rethink_ws && catkin_make

echo "source ~/rethink_ws/devel/setup.bash" >> ~/.bashrc

sudo apt install -y ros-noetic-moveit
sudo apt install -y ros-noetic-ros-controllers
sudo apt install -y ros-noetic-slam-gmapping

mkdir -p ~/rethink_ws/src/moveit_robots
cd ~/rethink_ws/src/moveit_robots
git init
git remote add -f origin https://github.com/ros-planning/moveit_robots.git
git config core.sparseCheckout true
echo 'baxter' >> .git/info/sparse-checkout
echo 'moveit_robots' >> .git/info/sparse-checkout
git pull origin kinetic-devel

echo "****************************** Installing Sawyer Packages ******************************"

cd ~/rethink_ws/src
wstool init .
git clone https://github.com/RethinkRobotics/sawyer_robot.git
wstool merge sawyer_robot/sawyer_robot.rosinstall
wstool update

ln -s ~/rethink_ws/src/intera_sdk/intera.sh ~/rethink_ws/intera.sh
sed -i '30s/.*/ros_version="noetic"/' ~/rethink_ws/src/intera_sdk/intera.sh

cd ~/rethink_ws/src
git clone https://github.com/RethinkRobotics/sawyer_simulator.git
echo -e "- git:\n    local-name: sns_ik\n    uri: https://github.com/RethinkRobotics-opensource/sns_ik.git\n    version: melodic-devel" >> ~/rethink_ws/src/sawyer_simulator/sawyer_simulator.rosinstall
wstool merge sawyer_simulator/sawyer_simulator.rosinstall
wstool update
sed -i 's/CV_LOAD_IMAGE_UNCHANGED/cv::IMREAD_UNCHANGED/g' ~/rethink_ws/src/sawyer_simulator/sawyer_gazebo/src/head_interface.cpp

echo "****************************** Installing Baxter Packages ******************************"

cd ~/rethink_ws/src
wstool merge https://raw.githubusercontent.com/RethinkRobotics/baxter/master/baxter_sdk.rosinstall
wstool update
sed -i 's/OSError, e/OSError as e/g' ~/rethink_ws/src/baxter_interface/src/baxter_interface/robot_enable.py

ln -s ~/rethink_ws/src/baxter/baxter.sh ~/rethink_ws/baxter.sh
sed -i '30s/.*/ros_version="noetic"/' ~/rethink_ws/src/baxter/baxter.sh

cd ~/rethink_ws/src
wstool merge https://raw.githubusercontent.com/RethinkRobotics/baxter_simulator/kinetic-devel/baxter_simulator.rosinstall
wstool update
sed -i 's/boost/std/g' ~/rethink_ws/src/baxter_simulator/baxter_sim_kinematics/src/arm_kinematics.cpp
sed -i 's/CV_LOAD_IMAGE_UNCHANGED/cv::IMREAD_UNCHANGED/g' ~/rethink_ws/src/baxter_simulator/baxter_sim_hardware/src/baxter_emulator.cpp
cd ~/rethink_ws && catkin_make

echo "****************************** Installing Turtlebot3 ******************************"
mkdir -p ~/turtlebot3_ws/src
cd ~/turtlebot3_ws/src
git clone https://github.com/ROBOTIS-GIT/turtlebot3.git
git clone https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git
git clone https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git
cd ~/turtlebot3_ws && catkin_make
echo "export TURTLEBOT3_MODEL=burger" >> ~/.bashrc
