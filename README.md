
# Verilog_IP_hierarchy_viewer

Verilog IP hierarchy viewer is a GUI tool that can be used to visualize hierarchically the instances and connections between modules in a given IP. Each module has listed ports, parameters and instances.
It uses Nicolas Bergont's Interactive Qt GraphViz display (https://github.com/nbergont/qgv) and Verific Verilog library parser.                                                                                    
Since the Verific library is a commercial source that is paid for, it is not included here. For information about the Verific Verilog parser and library, see www.verific.com. 


## Installation
1. Download sources from GIT : git clone                            
2. Download GraphViz library : http://www.graphviz.org/Download.php                                                                          
3. Configure GRAPHVIZ_PATH in Qt Creator GUI                                                                     
4. Open with Qt Creator & compile
    
## Build
Open the provided .pro file in QTCreator and run the build.
Tested and built in Windows 10, it should open and convert without problems in Linux.
For a successful build, you need the full source code of Verific.
Under Linux, after opening the .pro file, a full Makefile is written, which can also be built with the make command.
## Test

Printscreen png files in ./test folder


## Screenshots
Printscreen png files are located in ./doc folder                                                                                 
Select Verilog IP file:
![Alt text](/doc/Select_ip.png?raw=true "Optional Title")

Loaded modules hierarchy into viewer:
![Alt text](doc/printscreen_VIPH_viewer.png?raw=true "Optional Title")
![Alt text](doc/printscreen_VIPH_viewer2.png?raw=true "Optional Title")

Full design hierarchy in generated PNG:
![Alt text](doc/Full_design_hierarhy.png?raw=true "Optional Title")

