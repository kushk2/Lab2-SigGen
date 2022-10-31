#include "verilated.h"
#include "Vsiggen.h"
#include "verilated_vcd.c.h"
#include "vbuddy.cpp"

int main(int argc, char **argv, char **env){
    int clk;

    Verilated:commandArgs(argc, argv);
    //init top verilog instance
    Siggen* top = new Siggen;
    //init trace dump
    Verilated::traceEverOn(true);

    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("siggen.vcd");


}
