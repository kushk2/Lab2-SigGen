module ram2port#(
    parameter ADDRESS_WIDTH = 9,
    DATA_WIDTH = 8
)(
    input logic clk,
    input logic wr_en,
    input logic rd_en,


    input logic [ADDRESS_WIDTH - 1:0] rd_addr,
    input logic [ADDRESS_WIDTH - 1:0] wr_addr,

    input logic [DATA_WIDTH - 1:0] din,

    output logic [DATA_WIDTH-1:0] dout
);

logic [DATA_WIDTH-1:0] ram_array [2**ADDRESS_WIDTH-1:0];

initial begin
    $display("Loading rom.");
    $readmemh("sigrom.mem", ram_array);
end;

always_ff @(posedge clk)begin
    if(wr_en == 1) //if write enable on
        ram_array[wr_addr] <= din; //write data coming in to ram address specified by write_address
    if(rd_en == 1) //similarly for read
        dout <= ram_array[rd_addr]; //output data at read_address of ram to dout
end;

endmodule
