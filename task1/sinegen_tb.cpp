#include "Vsinegen.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

#include "vbuddy.cpp"

#define MAXSimCycles  10000 //10k
#define ADDwidth  8
#define ROMsize  256

int main(int argc, char **argv, char **env){
    int i;
    int clk;

    Verilated::commandArgs(argc, argv);
    // init top verilog instance
    Vsinegen* top = new Vsinegen;
    //init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("sinegen.vcd");

    //init Vbuddy
    if(vbdOpen() !=1) return(-1);
    vbdHeader("Lab 2:SineGen");

    //initialize simulation inputs
    top->clk = 1;
    top->rst = 0;
    top->en = 1;
    top->incr = 1;

    //run simulation for many clock cycles
    for(i = 0; i < MAXSimCycles; i++){
        //dump variables into VCD file and toggle clock
        for(clk = 0; clk < 2; clk++){
            tfp->dump(2*i+clk); //unit is in ps
            top->clk = !top->clk;
            top->eval ();
        }
        top->incr = vbdValue(); //increment by vbd value, skips in the array of sine values

        // plot rom output value on VBuddy
        vbdPlot(int(top->dout), 0, 255); //plot integer version of 'dout' from 'top', mapped between 0-255
        vbdCycle(i+1);
        // end plot

        //change input stimuli
        top->rst = (i < 2) | (i ==15);
        if(Verilated::gotFinish() || vbdGetkey() == 'q') exit(0);
    }
    vbdClose();
    tfp->close();
    exit(0);
}