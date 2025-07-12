module breakpoint1;

int val1;
int val2;

int result;
function int incr_static(input int a);
  result = a + 1;
  return result;
endfunction

function automatic int incr_dynamic(input int a);
  int result;
  result = a + 1;
  return result;
endfunction

initial begin
  val1 = 0;
  val1 = incr_static(val1);
  $display("0t ns val1 is 0x%0x", $time, val1);
  val1 = incr_static(val1);  // breakpoint line8 result == ?
  $display("0t ns val1 is 0x%0x", $time, val1);
end

initial begin
  val2 = 0;
  val2 = incr_dynamic(val2);
  $display("0t ns val2 is 0x%0x", $time, val2);
  val2 = incr_dynamic(val2); // breakpoint line14 result == ? 
  $display("0t ns val2 is 0x%0x", $time, val2);
end

endmodule



