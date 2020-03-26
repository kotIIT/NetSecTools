#!/bin/bash
#automated enumeration
#this script should perform automated scans by pulling network info from DHCP
#what to do
#get device IP adress
myIP="$(hostname -I)"
myInterface="$(ip -o -f inet addr show | awk '/scope global/ {print $2}')"
mySubnet="$(ip -o -f inet addr show | awk '/scope global/ {print $4}')"
outFile="Output/Devices.txt"
IPList="Output/IPs.txt"

getDeviceList()
{
    echo "Performing ARP Scan..."
    sudo netdiscover -r $mySubnet  -PN > $outFile
    sed  -i '$d' $outFile 
    awk '{print $1} ' $outFile > $IPList
    echo "Devices are:"
    cat $outFile
    
}


#Perform a scripted network scan to find devices
#Identify Open Ports
#Identify Default Credentials

ScanSubnet(){
    File="Output/scannedlist.xml"
    echo 
    echo "Scanning Subnet"
    echo $mySubnet
    nmap $mySubnet -sC -A --open  -A -oX  $outFile -webxml
}

ScanList(){
    outFile="Output/list.xml"
    echo 
    echo "Scanning Listed Devices..."
    nmap -iL  $IPList -sC --open -oX $outFile
}

Menu()
{
    echo "This is the menu of the script"
    echo ""
    echo "Enter 'ip' to find your IP and subnet"
    echo "Enter 'iface' to list device interface"
    echo "Enter the Port number to check if the port is open in the device list"
    echo ""
    echo "Press d. to listen for devices on the network"
    echo "Press l. to display the devices on the network"
    echo "Press s. to perform a scripted network scan  "
    echo "press m to display menu again"
    echo ""
    echo ""
    echo "To bypass this menu, enter the arguement before running the script"

}


ScanPort(){
    File='Output/Port'$arg'.txt'
    echo "Scanning for port" $arg
    nmap -iL  $IPList  -p$arg --open -oG $File >/dev/null
    gawk -i inplace '/open/{print $2} ' $File
    sed -i '1d'  $File
    cat $File
    }


makeChoice(){
  echo ""

  read -p "Select > " arg
  case $arg in   
    n|N) exit 0
esac

}

arg=$1

Output()
{
    case  $arg in
    l)echo "List of devices on the network: " 
        cat $IPList;;
    ip) echo "IP address and subnet is" $myIP;;
    iface) echo "Interface name is:" $myInterface;;
    d) getDeviceList ;;
    s) ScanSubnet ;;
    $1 | m)  Menu;;
    $arg) ScanPort ;;
esac

}

while true :
do
Output
makeChoice
done

