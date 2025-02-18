module conv_test;
   // parameter N = 5;
    //parameter M = 5;
    
    reg clk, rst;
    reg [7:0] a, b;
    wire [7:0] out;
    wire done;
    
    // Instantiate the convolution module
    conv_2d #(5,3) uut (
        .clk(clk), 
        .rst(rst), 
        .a(a), 
        .b(b), 
        .out(out), 
        .done(done)
    );
    
    // Clock generation
    always #5 clk = ~clk; // 10ns clock period
    
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        #100;
        
        
        
        rst = 0; // Deassert reset after some time
        
        // Apply inputs sequentially with proper timing
        #3 a = 8'd1; b = 8'd1;
        #20 a = 8'd2; b = 8'd0;
        #20 a = 8'd3; b = 8'd1;
        #20 a=8'd4; 
        #20 a = 8'd5;
        #40 a = 8'd6; b = 8'd0;
        #20 a=8'd7; b = 8'd1;
        #20 a=8'd8; b = 8'd0;
        #20 a=8'd9;
        #20 a=8'd10;
        #40 a=8'd11;b = 8'd1;
        #20 a=8'd12;b = 8'd0;
        #20 a=8'd13;b = 8'd1;
        #20 a=8'd14;
        #20 a=8'd15;
        #40 a=8'd16;
        #20 a=8'd17;
        #20 a=8'd18;
        #20 a=8'd19;
        #20 a=8'd20;
        #40 a=8'd21;
        #20 a=8'd22;
        #20 a=8'd23;
        #20 a=8'd24;
        #20 a=8'd25;

    end
    
endmodule
