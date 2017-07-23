
module tb_top ();

   int WDOG_TIMER = 1000; // A thousand cycles
   bit tb_clk;
   bit rst;


   processor mips(tb_clk, rst);




   initial begin
      $system("date");
      $system("uname -n");
      $system("whoami");
      $system("pwd");
   end


   initial begin
     $readmemh("$verif/imem.h", mips.imem_inst.RAM);
     $display("mem[%g] = %2X", 1, mips.imem_inst.RAM[1] );
   end



   always #1 tb_clk = ~tb_clk;

   always @(posedge tb_clk)begin
      static int time_counter = 0;
      if(time_counter++>WDOG_TIMER) $finish;

   end

endmodule

