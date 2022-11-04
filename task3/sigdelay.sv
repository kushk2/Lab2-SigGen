module sigdelay #(
    parameter A_WIDTH = 9, D_WIDTH = 8
)
(
    //interface signals
    input logic clk,    //clock
    input logic rst,    //reset
    input logic en,     //enable

    input logic wr_en, //write enable
    input logic rd_en, //read enable

    input logic [A_WIDTH - 1:0] offset, //ofset variable for the read address
    input logic [D_WIDTH - 1:0] din,

    output logic [D_WIDTH - 1:0] dout   //output data
);

logic [A_WIDTH - 1:0] wr_addrline; //interconnect wire from counter output to input of rom
logic [A_WIDTH - 1:0] rd_addrline; //address line = addrline


counter addrCounter(
    .clk (clk),
    .rst (rst),
    .en (en),
    .offset(offset),
    .count1(wr_addrline),
    .count2(rd_addrline)
);

ram2port sigRom(
    .clk(clk),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .wr_addr(wr_addrline),
    .rd_addr(rd_addrline),
    .din(din),
    .dout(dout)
);


endmodule
