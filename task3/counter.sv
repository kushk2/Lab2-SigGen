module counter #(
    parameter WIDTH = 9
)(
    //interface signals
    input logic             clk,    //clock
    input logic             rst,    //reset
    input logic             en,     //counter enable
    
    input logic [WIDTH - 1:0] offset, //make an offset for the counter

    output logic [WIDTH - 1:0] count1,   //count output
    output logic [WIDTH - 1:0] count2   //count delayed (output)  
);

always_ff @ (posedge clk) begin
    if(rst) begin 
    count1 <= {WIDTH{1'b0}};
    count2 <= {WIDTH{1'b0}};
    end //set count to 0 if reset it enabled
    else if (en) begin
    count1 <= count1 + 1;
    count2 <= count1 - offset;
    end
    //count normally for count1 (write) - offset for count2 (reading)
end

endmodule
