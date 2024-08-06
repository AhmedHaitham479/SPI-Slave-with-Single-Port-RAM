module RAM_SPI(din,rx_valid,clk,rst_n,tx_valid,dout);
parameter MEM_DEPTH=256;
parameter ADDR_SIZE=8;
parameter MEM_WIDTH=8;

input clk,rst_n,rx_valid;
input[MEM_WIDTH+1:0]din;
output reg [MEM_WIDTH-1:0]dout;
output reg tx_valid;

reg [ADDR_SIZE-1:0]addr_rd,addr_wr;

reg [MEM_WIDTH-1:0]mem[MEM_DEPTH-1:0]; 

always@(posedge clk)begin
  if(rst_n==0)begin
  dout<=0;
  tx_valid<=0;
  end
  else begin 
   if(rx_valid)begin
    case(din[9:8])
    2'b00:addr_wr<=din[7:0];
    2'b01:mem[addr_wr]<=din[7:0];
    2'b10:addr_rd<=din[7:0];
    endcase
   end 
    if(din[9:8]==2'b11)begin 
    dout<=mem[addr_rd];
    tx_valid<=1;
    end
    else
    tx_valid<=0;
   end 
  
end

 
endmodule