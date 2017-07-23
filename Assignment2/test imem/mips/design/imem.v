module imem(input  logic [5:0]  a,
            output logic [7:0] rd);

  logic [7:0] RAM[0:63];

//  initial
//    begin
//      $readmemh("memfile.dat",RAM); // initialize memory
//    end

  assign rd = RAM[a]; // word aligned
endmodule

