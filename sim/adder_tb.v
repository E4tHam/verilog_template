
module adder_tb ();

// test bench contents
reg [31:0] a, b;
wire [31:0] y;
wire cout;

adder a0 (
    .a(a), .b(b),
    .y(y), .cout(cout)
);
//

initial begin
$dumpfile( "dump.fst" );
$dumpvars;
$display( "Begin simulation." );
//\\ =========================== \\//

a = 1;
b = 2;
#1;
if (y==3)
    $display("Passed!");
else
    $error("Failed: %d + %d", a, b);

//\\ =========================== \\//
$display( "End simulation.");
$finish;
end

endmodule
