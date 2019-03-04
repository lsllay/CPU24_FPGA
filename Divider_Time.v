`timescale 1ns / 1ps
module Divider_Time(
        input clk,
        input reset,
        output reg clk_out_m,
        output reg clk_out_s,
        output reg clk_out_beep,
        output reg clk_display
   );

    reg [24:0] counter0;//beep   
    reg [25:0] counter1;//s    
    reg [26:0] counter2;//m      
    reg [13:0] counter3;//clk_display  

    initial counter0 = 0;
    initial counter1 = 0;
    initial counter2 = 0;
    initial counter3 = 0;

    //beep--25000000--2HZ
    always@(posedge clk)
    begin
        if(reset == 0 || counter0 == 25000000/2) counter0 <= 0;  //仿真时数改为0
        else counter0 <= counter0 + 1;
    end

    always@(posedge clk)
    begin 
        if(reset == 0) clk_out_beep <= 0;
        else if(counter0 == 25000000/2) clk_out_beep <= ~clk_out_beep;//仿真时数改为0
        else clk_out_beep <= clk_out_beep;
    end

    //s----50000000----1HZ
    always@(posedge clk)
    begin  
        if( reset == 0 || counter1 == 50000000/2)  counter1 <= 0;//仿真时数改为0
        else counter1 <= counter1 + 1;
    end

    always@(posedge clk)
    begin 
        if(reset == 0) clk_out_s <= 0;
        else if(counter1 == 50000000/2) clk_out_s <= ~clk_out_s;//仿真时数改为0
        else clk_out_s <= clk_out_s;
    end

    //m-------100000000---1/2HZ
    always@(posedge clk )
    begin
        if( reset == 0 || counter2 == 100000000/2) counter2 <= 0;//仿真时数改为0
        else counter2 <= counter2 + 1;
    end

    always@(posedge clk)
    begin 
        if(reset == 0) clk_out_m <= 0;
        else if(counter2 ==100000000/2) clk_out_m <= ~clk_out_m;//仿真时数改为0
        else clk_out_m <= clk_out_m;
    end

    //clk_display------1<<12
    always@(posedge clk )
    begin
        if( reset == 0 || counter3 == 1<<12) counter3 <= 0;//仿真时数改为0
        else counter3 <= counter2 + 1;
    end

    always@(posedge clk)
    begin 
        if(reset == 0) clk_display <= 0;
        else if(counter3== 1<<12) clk_display <= ~clk_display;//仿真时数改为0
        else clk_display <= clk_display;
    end

    endmodule
