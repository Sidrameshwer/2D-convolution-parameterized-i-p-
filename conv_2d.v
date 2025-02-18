module conv_2d#(parameter N=5,M=3)(
    input clk,rst,
    input [7:0] a,b,
    output  reg [7:0] out,
    output reg done
    );
    reg [7:0] A[0:N-1][0:N-1];
    reg [7:0] B[0:M-1][0:M-1];
    //reg [7:0] Y[0:N-M][0:N-M];//N-M+1 bits
    reg [3:0] state,next_state;
    localparam s_init=9,s0=0,s1=1,s2=2,s3=3,s4=4,s5=5,s6=6,s7=7,s8=8;
    integer i,j,k,l,p,q;
    reg [7:0]sum=0;
    always@(posedge clk)
       begin
          if(rst)
          state<=s_init;
          else
          state<=next_state;
      end
   always@(negedge clk)
      begin
        case(state)
        s_init: begin
                i<=0;
                j<=0;
                k<=0;
                l<=0;
                p<=0;
                q<=0;
                done<=0;
                end
        s0:
             begin
                if(i<M && j<M) 
                begin
                    A[i][j] <= a;
                    B[i][j]<=b;
                end
                else if(M<=i<N)
                A[i][j] <= a;
            end
        s1:
            begin
                j<=j+1;
            end
        s2:
            begin
                j<=0;
                i<=i+1;
            end
            
        s3: 
            begin
            if(p<M)
            begin
                if(q<M)
                    begin
                    if(k < N - M + 1) begin //Critical understand again
                      if (l < N - M + 1)    //critical
                        sum <= A[k+p][l+q]* B[p][q] + sum;
                        end
                    end
            end
            end
        s4: 
            begin
            q<=q+1;
            end
        s5: 
            begin
                q<=0;
                p<=p+1;
            end
        s6: 
            begin
             
                out<=sum;
                p<=0;
                q<=0;
                sum<=0;
                l<=l+1;
            end
        s7: 
            begin
                l<=0;
                k<=k+1;
            end    
        s8: 
            done<=1;
        
        endcase
      end
      
   always@(*) 
    begin
        case(state)
        s_init: next_state=s0;
        s0: begin
            if (i < N) 
                begin
                    if(j<N)
                        next_state = s1;
                    else
                        next_state = s2;
                end 
            else 
                next_state = s3;
            end
        s1: 
            next_state=s0;
        s2: 
            next_state=s0;
        s3: begin
            if(k<N-M+1)
            begin
                if(l<N-M+1)
                begin
                    if (p<M) 
                        begin
                            if(q<M)
                                next_state = s4;
                            else
                                next_state = s5;
                        end 
                    else 
                        next_state = s6;
                end
                else 
                    next_state=s7;
                end
            else
                next_state=s8;
            end
        s4: 
            next_state=s3;
        s5: 
            next_state=s3;
        s6: 
            next_state=s3;
        s7: 
            next_state=s3;
        s8: 
            next_state=s8;
        endcase
    end
endmodule
