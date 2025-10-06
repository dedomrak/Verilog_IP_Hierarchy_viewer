#include <iostream>

#include "./verilog/veri_file.h"
#include "./verilog/VeriModule.h"
#include "./verilog/VeriId.h"
#include "./verilog/VeriExpression.h"
#include "./containers/Map.h"
#include "./containers/Array.h"

#include <string>
using namespace std ;
#ifdef VERIFIC_NAMESPACE
using namespace Verific ;
#endif

//int main()
std::string extractDotString(std::string fileName)
{
    char transition[64] ;
    unsigned module_cnt = 0 ;
    unsigned field_cnt = 0 ;
    Array transition_table ;
    Array instantiation_table ;
    Array module_table ;
    std::string resStr;

    if (!veri_file::Analyze(fileName.c_str(), veri_file::SYSTEM_VERILOG)) return std::string() ;

    resStr += "digraph Verific {\n";
    resStr += "   rankdir = LR\n";
    resStr +="   node [shape=box]\n";
    resStr += "   edge [dir=forward]\n";

    Array *tops = veri_file::GetTopModules() ;

    MapIter mi ;
    VeriModule *mod, *top ;
    unsigned i ;
    FOREACH_VERILOG_MODULE(mi, mod) {
        if (!mod || mod->IsPackage() || mod->IsRootModule()) continue ;
        module_table.Insert(mod) ;
    }

    unsigned mc ;
    FOREACH_ARRAY_ITEM(&module_table, mc, mod) {
        resStr += "   cell" + std::to_string(module_cnt) ;
        resStr += " [label=< <TABLE BORDER=\"0\" CELLBORDER=\"1\" CELLSPACING=\"0\">\n";

        unsigned found = 0 ;
        FOREACH_ARRAY_ITEM(tops, i, top) {
            if (Strings::compare(top->Name(), mod->Name())) {
                found = 1 ;
                break ;
            }
        }

        if (found) {
            resStr +="      <TR> <TD ALIGN=\"left\" PORT=\"f" + std::to_string(field_cnt++) + "\" COLOR=\"red\" BGCOLOR=\"yellow\"> <FONT COLOR=\"red\">MODULE : " + std::string(mod->Name()) + "</FONT> </TD> </TR>\n";
        }
        else {
            resStr +="      <TR> <TD ALIGN=\"left\" PORT=\"f" +std::to_string(field_cnt++) + "\" BGCOLOR=\"gray\">MODULE : " +  std::string(mod->Name()) + "</TD> </TR>\n";
        }

        Array *ports = mod->GetPorts();
        int numPorts = 0;
        if (ports) {
            VeriIdDef *port ;
            FOREACH_ARRAY_ITEM(ports, i, port) {
                numPorts++;
                if(numPorts<=10)
                    resStr +="      <TR> <TD ALIGN=\"left\" PORT=\"f" +std::to_string( field_cnt++) + "\">   port : " +  std::string(port->Name()) + "</TD> </TR>\n";
            }
        }

        Array *params = mod->GetParameters();
        int numParms = 0;
        if (params) {
            VeriIdDef *param ;
            FOREACH_ARRAY_ITEM(params, i, param) {
                numParms++;
                if(numParms<=5) {
                    resStr += "      <TR> <TD ALIGN=\"left\" PORT=\"f" + std::to_string(field_cnt++) + "\">   parameter : " + std::string( param->Name()) ;
                    VeriExpression *initvalue = param->GetInitialValue();
                    if (initvalue) {
                        resStr += " = " + std::string(initvalue->GetPrettyPrintedString()) + "</TD> </TR>\n";
                    }
                }
            }
        }

        Array *module_items = mod->GetModuleItems() ;
        VeriModuleItem *module_item ;
        FOREACH_ARRAY_ITEM(module_items, i, module_item) {
            switch (module_item->GetClassId()) {
            case ID_VERIMODULEINSTANTIATION:
            {
                VeriModuleInstantiation *mod_inst = static_cast<VeriModuleInstantiation*>(module_item) ;
                unsigned j ;
                VeriInstId *inst_id ;
                FOREACH_ARRAY_ITEM(mod_inst->GetIds(), j, inst_id) {
                    if (!inst_id) continue ;

                    instantiation_table.Insert(inst_id) ;
                    resStr += "      <TR> <TD ALIGN=\"left\" PORT=\"f" + std::to_string(field_cnt) + "\">   instantiation : " + std::string( mod_inst->GetModuleName()) + " : "  + std::string(inst_id->InstName()) + "</TD> </TR>\n";
                    unsigned k ;
                    VeriModule *inst ;
                    FOREACH_ARRAY_ITEM(&module_table, k, inst) {
                        if (Strings::compare(inst_id->GetModuleReference(), inst->Name())) {
                            sprintf (transition, "   cell%d:f%d -> cell%d:f0 ;", module_cnt, field_cnt, k) ;
                            char *trans = Strings::save(transition) ;
                            transition_table.Insert(trans) ;
                        }
                    }
                    field_cnt++ ;
                }
            }
            default :  ;
            }
        }

        resStr += "   </TABLE> >] ;\n";
        field_cnt = 0 ;
        module_cnt++ ;
    }


    char *trans ;
    FOREACH_ARRAY_ITEM(&transition_table, i, trans) {
        resStr +=std::string(trans) +"\n" ;
    }

    resStr += "}\n" ;
//    std::cout << resStr;
    return resStr ;
}



