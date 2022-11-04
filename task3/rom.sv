module rom #(
    parameter ADDRESS_WIDTH = 9,
    DATA_WIDTH = 8, WIDTH = 8
)(
    input logic clk,
    input logic [ADDRESS_WIDTH-1:0] addr1,
    input logic [ADDRESS_WIDTH-1:0] addr2,

    input logic [WIDTH-1:0] offset,

    output logic [DATA_WIDTH-1:0] dout,
);

logic [DATA_WIDTH-1:0] rom_array [2**ADDRESS_WIDTH-1:0];

initial begin
    $display("Loading rom.");
    $readmemh("sigrom.mem", rom_array);
end;

always_ff @(posedge clk)begin
    //output is synchronous
    dout <= rom_array[addr1];
end

endmodule
