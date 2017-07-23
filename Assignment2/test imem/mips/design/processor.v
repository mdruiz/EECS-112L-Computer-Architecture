
module processor(input clock, input reset);
    
    logic [5:0] addr;
    logic [7:0] rdData;

    imem imem_inst(addr, rdData);

endmodule
