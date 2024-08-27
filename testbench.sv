module fifo_tb;
    // Inputs
    reg clk;
    reg rst;
    reg rd;
    reg wr;
    reg [7:0] data_in;

    // Outputs
    wire full;
    wire empty;
    wire [7:0] data_out;

    // Instantiate the FIFO module
    fifo dut (
        .clk(clk),
        .rst(rst),
        .rd(rd),
        .wr(wr),
        .data_in(data_in),
        .full(full),
        .empty(empty),
        .data_out(data_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Initialize signals
    initial begin
        clk = 0;
        rst = 1;
        rd = 0;
        wr = 0;
        data_in = 0;

        // Reset sequence
        #10 rst = 0;
        #10 rst = 1;

        // Write and Read sequence
        #20 wr = 1;
        data_in = 8'hAA;
        #10 wr = 0;

        #30 wr = 1;
        data_in = 8'h55;
        #10 wr = 0;

        #40 rd = 1;
        #10 rd = 0;

        #50 rd = 1;
        #10 rd = 0;

        // Add more test sequences as needed

        // End simulation
        #10 $finish;
    end

    // Display simulation results
    always @(posedge clk) begin
        $display("Time=%t wr_ptr=%d rd_ptr=%d full=%b empty=%b data_out=%h", $time, dut.wr_ptr, dut.rd_ptr, full, empty, data_out);
    end
endmodule

