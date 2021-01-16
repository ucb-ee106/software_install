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

echo "********************Run wstool init"
wstool init

echo "********************Install Sawyer packages"
yes | wstool merge https://raw.githubusercontent.com/ucb-ee106/sawyer_simulator/master/sawyer_simulator.rosinstall

echo "********************Run wstool update"
wstool update

echo "********************Create a symlink for intera.sh"
ln -s ~/rethink_ws/src/intera_sdk/intera.sh ~/rethink_ws/intera.sh

echo "****************************** Installing Baxter Packages ******************************"

echo "********************Move to src directory of Rethink workspace"
cd ~/rethink_ws/src

echo "********************Install Baxter packages"
yes | wstool merge https://raw.githubusercontent.com/ucb-ee106/baxter_simulator/kinetic-devel/baxter_simulator.rosinstall

echo "********************Run wstool update"
wstool update

echo "********************Build Rethink workspace"
cd ~/rethink_ws && catkin_make

echo "********************Create a symlink for baxter.sh"
ln -s ~/rethink_ws/src/baxter/baxter.sh ~/rethink_ws/baxter.sh

echo "****************************** Installing TurtleBot3 ******************************"

echo "********************Create a workspace for the TurtleBot3 packages"
mkdir -p ~/turtlebot3_ws/src

echo "********************Move to src directory of TurtleBot3 workspace"
cd ~/turtlebot3_ws/src

echo "********************Clone turtlebot3 repository"
git clone -b noetic-devel https://github.com/ROBOTIS-GIT/turtlebot3.git

echo "********************Clone turtlebot3_msgs repository"
git clone -b noetic-devel https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git

echo "********************Clone turtlebot3_simulations repository"
git clone -b noetic-devel https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git

echo "********************Build TurtleBot3 workspace"
cd ~/turtlebot3_ws && catkin_make

echo "********************Source workspace in .bashrc file"
echo "source ~/turtlebot3_ws/devel/setup.bash" >> ~/.bashrc

echo "********************Set the TurtleBot3 model to Burger"
echo "export TURTLEBOT3_MODEL=burger" >> ~/.bashrc

echo "****************************** Installing AR Tags Package ******************************"

echo "********************Create a workspace for the ar_tags package"
mkdir -p ~/ar_tags_ws/src

echo "********************Initialize AR Tags workspace"
cd ~/ar_tags_ws/src && catkin_init_workspace

echo "********************Clone ar_tags repository"
git clone https://github.com/ucb-ee106/ar_tags

echo "********************Build AR Tags workspace"
cd ~/ar_tags_ws && catkin_make

echo "********************Source workspace in .bashrc file"
echo "source ~/ar_tags_ws/devel/setup.bash" >> ~/.bashrc
