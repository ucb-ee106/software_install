echo "********************Set up computer to accept software from packages.ros.org"
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

echo "********************Set up keys"
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

echo "********************Make sure Debian package index is up-to-date"
sudo apt update

echo "********************Install ROS Noetic"
yes | sudo apt install ros-noetic-desktop-full

echo "********************Source ROS in .bashrc file"
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

echo "********************Source .bashrc file"
source ~/.bashrc

echo "********************Install bootstrap dependencies"
yes | sudo apt-get install python3-rosdep python3-rosinstall-generator python3-vcstool build-essential python3-wstool

echo "********************Run sudo rosdep init"
sudo rosdep init

echo "********************Run rosdep update"
rosdep update
