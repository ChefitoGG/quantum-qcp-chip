module qcp_timer (
    input wire clk,
    input wire rst_n,
    input wire start_pulse,
    input wire [6:0] duration,
    output reg rf_enable,
    output reg reading_mode
);

    localparam IDLE  = 2'b00;
    localparam PULSE = 2'b01;
    localparam READ  = 2'b10;

    reg [1:0] state;
    reg [7:0] counter;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state        <= IDLE;
            counter      <= 8'b0;
            rf_enable    <= 1'b0;
            reading_mode <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    rf_enable    <= 1'b0;
                    reading_mode <= 1'b0;
                    counter      <= 8'b0;
                    if (start_pulse) begin
                        state <= PULSE;
                    end
                end

                PULSE: begin
                    rf_enable <= 1'b1;
                    if (counter >= duration) begin
                        rf_enable <= 1'b0;
                        counter   <= 8'b0;
                        state     <= READ;
                    end else begin
                        counter <= counter + 1;
                    end
                end

                READ: begin
                    reading_mode <= 1'b1;
                    if (counter >= 8'd200) begin
                        state   <= IDLE;
                        counter <= 8'b0;
                    end else begin
                        counter <= counter + 1;
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end
endmodule
