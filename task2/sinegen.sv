module sinegen #(
    parameter A_WIDTH = 8, D_WIDTH = 8, WIDTH = 8
)
(
    //interface signals
    input logic clk,    //clock
    input logic rst,    //reset
    input logic en,     //enable

    input logic offset, //ofset variable for add2

    //input logic  [WIDTH - 1:0] off, //offset for data2

    output logic [D_WIDTH - 1:0] dout1,   //output data
    output logic [D_WIDTH - 1:0] dout2   //output data
);

logic [A_WIDTH - 1:0] address; //interconnect wire from counter output to input of rom
//logic [A_WIDTH - 1:0] address; //doesnt allow for 2 connections?


counter addrCounter(
    .clk (clk),
    .rst (rst),
    .en (en),
    .count(address)
);

rom sineRom(
    .clk(clk),
    .addr1(address),
    .addr2(address),
    .dout1(dout1),
    .dout2(dout2),
    .offset(offset)
);


endmodule
