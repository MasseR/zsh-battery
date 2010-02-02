#include <iostream>
#include <fstream>
#include <string>
#include <sys/stat.h>
#include <cstdlib>

using namespace std;

const string BAT0("/proc/acpi/battery/BAT0");
const string BAT1("/proc/acpi/battery/BAT1");
const string AC("/proc/acpi/ac_adapter/ACAD/state");

inline bool fileExists(string filename)
{
    struct stat statbuffer;
    int status;
    
    status = stat(filename.c_str(), &statbuffer);

    return status==0?true:false;
}

inline bool acPower(string filename)
{
    string state;
    ifstream file(filename.c_str());

    file >> state;
    file >> state;

    file.close();

    if(state == string("off-line"))
        return false;
    else
        return true;
}

// Get the design capacity
inline int batteryCapacity(string dir)
{
    string filename(dir + string("/info"));
    ifstream file(filename.c_str());
    string temp;
    int capacity = 0;
    int state = 0;

    while(!file.eof())
    {
        file >> temp;
        if(temp == "design")
            state = 1;
        else if(state == 1 && temp == "capacity:")
            state = 2;
        else if(state == 2)
        {
            capacity = atoi(temp.c_str());
            state = 0;
            break;
        }
        else
            state = 0;
    }

    file.close();
    return capacity;
}

int main(void)
{
    string battery("");
    // Check whether we are on AC power and print an upwards arrow to symbolize
    // AC current
    if(fileExists(AC))
        if(acPower(AC))
            cout << "↑";
    if(fileExists(BAT0))
        battery = BAT0;
    else if(fileExists(BAT1))
        battery = BAT1;
    // We have no batteries o.O. Exit with return code 0
    if(battery == string(""))
        return 0;

    batteryCapacity(battery);
    return 0;
}
