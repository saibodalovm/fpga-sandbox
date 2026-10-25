module top
(
    input  logic       clk,
    output logic [5:0] led
);

    logic [26:0] counter = '0;

    always_ff @(posedge clk) begin
        counter <= counter + 1'b1;
    end

    assign led = ~counter[26:21];

endmodule
