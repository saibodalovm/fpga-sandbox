module top
(
    input  logic       clk,
    input  logic       btn1,
    input  logic       btn2,
    output logic [5:0] led
);

    localparam int CLK_DIV = 5_400_000;

    logic [22:0] div_cnt = '0;
    logic        tick;

    always_ff @(posedge clk) begin
        if (div_cnt == CLK_DIV - 1) begin
            div_cnt <= '0;
            tick    <= 1'b1;
        end else begin
            div_cnt <= div_cnt + 1'b1;
            tick    <= 1'b0;
        end
    end

    logic [5:0] light = 6'b000001;

    logic rst_pressed;
    logic start_pressed;

    assign rst_pressed   = ~btn2;
    assign start_pressed = ~btn1;

    always_ff @(posedge clk) begin
        if (rst_pressed) begin
            light <= 6'b000000;
        end else if (start_pressed) begin
            if (light == 6'b000000)
                light <= 6'b000001;
        end else if (tick) begin
            if (light != 6'b000000)
                light <= {light[4:0], light[5]};
        end
    end

    assign led = ~light;

endmodule
