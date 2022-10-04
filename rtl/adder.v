
module adder (
    input        [31:0] a, b,
    output wire  [31:0] y,
    output wire         cout
);

assign {cout,y} = a + b;

endmodule
