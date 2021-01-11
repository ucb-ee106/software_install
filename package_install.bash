echo "****************************** Install MoveIt! and Baxter MoveIt! Configuration ******************************"

echo "********************Create a workspace for the Rethink packages"
mkdir -p ~/rethink_ws/src

echo "********************Initialize Rethink workspace"
cd ~/rethink_ws/src && catkin_init_workspace

echo "********************Build Rethink workspace"
cd ~/rethink_ws && catkin_make

echo "********************Source workspace in .bashrc file"
echo "source ~/rethink_ws/devel/setup.bash" >> ~/.bashrc

echo "********************Source .bashrc file"
source ~/.bashrc

echo "********************Install MoveIt!"
yes | sudo apt install ros-noetic-moveit

echo "********************Install controllers package"
yes | sudo apt install ros-noetic-ros-controllers

echo "********************Install SLAM package"
yes | sudo apt install ros-noetic-slam-gmapping

echo "********************Create a directory for Baxter MoveIt! Configuration"
mkdir -p ~/rethink_ws/src/moveit_robots

echo "********************Move to Baxter MoveIt! Configuration directory"
cd ~/rethink_ws/src/moveit_robots

echo "********************Create an empty git repository"
git init

echo "********************Create origin"
git remote add -f origin https://github.com/ros-planning/moveit_robots.git

echo "********************Set repository to only pull certain directories"
git config core.sparseCheckout true

echo "********************Set repository to pull baxter directory"
echo 'baxter' >> .git/info/sparse-checkout

echo "********************Set repository to pull moveit_robots directory"
echo 'moveit_robots' >> .git/info/sparse-checkout

echo "********************Pull Baxter MoveIt! Configuration"
git pull origin kinetic-devel

echo "****************************** Install Sawyer Packages ******************************"

echo "********************Move to src directory of Rethink workspace"
cd ~/rethink_ws/src

echo "********************Run wstool init ."
wstool init .

echo "********************Clone sawyer_robot repository"
git clone https://github.com/RethinkRobotics/sawyer_robot.git

echo "********************Install sawyer_robot package"
yes | wstool merge sawyer_robot/sawyer_robot.rosinstall

echo "********************Run wstool update"
wstool update

echo "********************Create a symlink for intera.sh"
ln -s ~/rethink_ws/src/intera_sdk/intera.sh ~/rethink_ws/intera.sh

echo "********************Set the ROS version to Noetic"
sed -i '30s/.*/ros_version="noetic"/' ~/rethink_ws/src/intera_sdk/intera.sh

echo "********************Move to src directory of Rethink workspace"
cd ~/rethink_ws/src

echo "********************Clone sawyer_simulator repository"
git clone https://github.com/RethinkRobotics/sawyer_simulator.git

echo "********************Add the sns_ik package to the .rosinstall file"
echo -e "- git:\n    local-name: sns_ik\n    uri: https://github.com/RethinkRobotics-opensource/sns_ik.git\n    version: melodic-devel" >> ~/rethink_ws/src/sawyer_simulator/sawyer_simulator.rosinstall

echo "********************Install sawyer_simulator package"
yes | wstool merge sawyer_simulator/sawyer_simulator.rosinstall

echo "********************Run wstool update"
wstool update

echo "********************Make minor syntax edit in ~/rethink_ws/src/sawyer_simulator/sawyer_gazebo/src/head_interface.cpp"
sed -i 's/CV_LOAD_IMAGE_UNCHANGED/cv::IMREAD_UNCHANGED/g' ~/rethink_ws/src/sawyer_simulator/sawyer_gazebo/src/head_interface.cpp

echo "****************************** Installing Baxter Packages ******************************"

echo "********************Move to src directory of Rethink workspace"
cd ~/rethink_ws/src

echo "********************Install baxter_sdk package package"
yes | wstool merge https://raw.githubusercontent.com/RethinkRobotics/baxter/master/baxter_sdk.rosinstall

echo "********************Run wstool update"
wstool update

echo "********************Make minor syntax edit in ~/rethink_ws/src/baxter_interface/src/baxter_interface/robot_enable.py"
sed -i 's/OSError, e/OSError as e/g' ~/rethink_ws/src/baxter_interface/src/baxter_interface/robot_enable.py

echo "********************Create a symlink for baxter.sh"
ln -s ~/rethink_ws/src/baxter/baxter.sh ~/rethink_ws/baxter.sh

echo "********************Set the ROS version to Noetic"
sed -i '30s/.*/ros_version="noetic"/' ~/rethink_ws/src/baxter/baxter.sh

echo "********************Move to src directory of Rethink workspace"
cd ~/rethink_ws/src

echo "********************Install baxter_simulator package package"
yes | wstool merge https://raw.githubusercontent.com/RethinkRobotics/baxter_simulator/kinetic-devel/baxter_simulator.rosinstall

echo "********************Run wstool update"
wstool update

echo "********************Make minor syntax edit in ~/rethink_ws/src/baxter_simulator/baxter_sim_kinematics/src/arm_kinematics.cpp"
sed -i 's/boost/std/g' ~/rethink_ws/src/baxter_simulator/baxter_sim_kinematics/src/arm_kinematics.cpp

echo "********************Make minor syntax edit in ~/rethink_ws/src/baxter_simulator/baxter_sim_hardware/src/baxter_emulator.cpp"
sed -i 's/CV_LOAD_IMAGE_UNCHANGED/cv::IMREAD_UNCHANGED/g' ~/rethink_ws/src/baxter_simulator/baxter_sim_hardware/src/baxter_emulator.cpp

echo "********************Build Rethink workspace"
cd ~/rethink_ws && catkin_make

echo "****************************** Installing TurtleBot3 ******************************"

echo "********************Create a workspace for the TurtleBot3 packages"
mkdir -p ~/turtlebot3_ws/src

echo "********************Move to src directory of TurtleBot3 workspace"
cd ~/turtlebot3_ws/src

echo "********************Clone turtlebot3 repository"
git clone https://github.com/ROBOTIS-GIT/turtlebot3.git

echo "********************Clone turtlebot3_msgs repository"
git clone https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git

echo "********************Clone turtlebot3_simulations repository"
git clone https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git

echo "********************Build TurtleBot3 workspace"
cd ~/turtlebot3_ws && catkin_make

echo "********************Set the TurtleBot3 model to Burger"
echo "export TURTLEBOT3_MODEL=burger" >> ~/.bashrc
