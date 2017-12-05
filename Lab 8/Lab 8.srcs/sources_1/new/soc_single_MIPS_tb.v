`timescale 1ns / 1ps

module soc_single_MIPS_tb;
    reg clk, rst;
    reg [31:0] gpi1, gpi2, count;
    wire [31:0] gpo1, gpo2;

    soc_single_MIPS DUT(clk, rst, gpi1, gpi2, gpo1, gpo2);

    initial begin
        rest;
        for(count = 0; count < 14; count = count + 1) begin
            gpi1=count;
            gpi2=count;
            tik_tok;

            while(DUT.fac.done != 1 && DUT.fac.error != 1) begin
                tik_tok;
            end

            case(count)
                32'd0:  if(DUT.fac.prod!=1) fail;
                32'd1:  if(DUT.fac.prod!=1) fail;
                32'd2:  if(DUT.fac.prod!=2) fail;
                32'd3:  if(DUT.fac.prod!=6) fail;
                32'd4:  if(DUT.fac.prod!=24) fail;
                32'd5:  if(DUT.fac.prod!=120) fail;
                32'd6:  if(DUT.fac.prod!=720) fail;
                32'd7:  if(DUT.fac.prod!=5040) fail;
                32'd8:  if(DUT.fac.prod!=40320) fail;
                32'd9:  if(DUT.fac.prod!=362880) fail;
                32'd10: if(DUT.fac.prod!=3628800) fail;
                32'd11: if(DUT.fac.prod!=39916800) fail;
                32'd12: if(DUT.fac.prod!=479001600) fail;
                32'd13: if(DUT.fac.error==1) pass;
                default: fail;
            endcase

            //tik_tok;
        end
    end

    task tik_tok;
    begin
        clk = 1; #5;
        clk = 0; #5;
    end
    endtask

    task rest;
    begin
        rst=1; #5;
        rst=0; #5;
    end
    endtask

    task fail;
    begin
        $display ("SOC Single MIPS TB FAILED");
        $display ("Failed at %d:%d", count, DUT.fac.prod);
        #50 $stop;
        #20 $finish;
    end
    endtask

    task pass;
    begin
        tik_tok;
        tik_tok;
        tik_tok;
        tik_tok;
        tik_tok;
        tik_tok;
        tik_tok;
        $display ("SOC Single MIPS TB PASSED");
        #50 $stop;
        #20 $finish;
    end
    endtask
endmodule
