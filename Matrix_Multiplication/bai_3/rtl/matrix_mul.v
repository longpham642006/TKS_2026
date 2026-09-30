module mat_vec_8x8_parallel #(
    parameter DATA_WIDTH = 16,
    parameter ACC_WIDTH  = 40
)(
    // Matrix A: 8x8
    input signed [DATA_WIDTH-1:0] A00,
    input signed [DATA_WIDTH-1:0] A01,
    input signed [DATA_WIDTH-1:0] A02,
    input signed [DATA_WIDTH-1:0] A03,
    input signed [DATA_WIDTH-1:0] A04,
    input signed [DATA_WIDTH-1:0] A05,
    input signed [DATA_WIDTH-1:0] A06,
    input signed [DATA_WIDTH-1:0] A07,

    input signed [DATA_WIDTH-1:0] A10,
    input signed [DATA_WIDTH-1:0] A11,
    input signed [DATA_WIDTH-1:0] A12,
    input signed [DATA_WIDTH-1:0] A13,
    input signed [DATA_WIDTH-1:0] A14,
    input signed [DATA_WIDTH-1:0] A15,
    input signed [DATA_WIDTH-1:0] A16,
    input signed [DATA_WIDTH-1:0] A17,

    input signed [DATA_WIDTH-1:0] A20,
    input signed [DATA_WIDTH-1:0] A21,
    input signed [DATA_WIDTH-1:0] A22,
    input signed [DATA_WIDTH-1:0] A23,
    input signed [DATA_WIDTH-1:0] A24,
    input signed [DATA_WIDTH-1:0] A25,
    input signed [DATA_WIDTH-1:0] A26,
    input signed [DATA_WIDTH-1:0] A27,

    input signed [DATA_WIDTH-1:0] A30,
    input signed [DATA_WIDTH-1:0] A31,
    input signed [DATA_WIDTH-1:0] A32,
    input signed [DATA_WIDTH-1:0] A33,
    input signed [DATA_WIDTH-1:0] A34,
    input signed [DATA_WIDTH-1:0] A35,
    input signed [DATA_WIDTH-1:0] A36,
    input signed [DATA_WIDTH-1:0] A37,

    input signed [DATA_WIDTH-1:0] A40,
    input signed [DATA_WIDTH-1:0] A41,
    input signed [DATA_WIDTH-1:0] A42,
    input signed [DATA_WIDTH-1:0] A43,
    input signed [DATA_WIDTH-1:0] A44,
    input signed [DATA_WIDTH-1:0] A45,
    input signed [DATA_WIDTH-1:0] A46,
    input signed [DATA_WIDTH-1:0] A47,

    input signed [DATA_WIDTH-1:0] A50,
    input signed [DATA_WIDTH-1:0] A51,
    input signed [DATA_WIDTH-1:0] A52,
    input signed [DATA_WIDTH-1:0] A53,
    input signed [DATA_WIDTH-1:0] A54,
    input signed [DATA_WIDTH-1:0] A55,
    input signed [DATA_WIDTH-1:0] A56,
    input signed [DATA_WIDTH-1:0] A57,

    input signed [DATA_WIDTH-1:0] A60,
    input signed [DATA_WIDTH-1:0] A61,
    input signed [DATA_WIDTH-1:0] A62,
    input signed [DATA_WIDTH-1:0] A63,
    input signed [DATA_WIDTH-1:0] A64,
    input signed [DATA_WIDTH-1:0] A65,
    input signed [DATA_WIDTH-1:0] A66,
    input signed [DATA_WIDTH-1:0] A67,

    input signed [DATA_WIDTH-1:0] A70,
    input signed [DATA_WIDTH-1:0] A71,
    input signed [DATA_WIDTH-1:0] A72,
    input signed [DATA_WIDTH-1:0] A73,
    input signed [DATA_WIDTH-1:0] A74,
    input signed [DATA_WIDTH-1:0] A75,
    input signed [DATA_WIDTH-1:0] A76,
    input signed [DATA_WIDTH-1:0] A77,

    // Vector X: 8x1
    input signed [DATA_WIDTH-1:0] X0,
    input signed [DATA_WIDTH-1:0] X1,
    input signed [DATA_WIDTH-1:0] X2,
    input signed [DATA_WIDTH-1:0] X3,
    input signed [DATA_WIDTH-1:0] X4,
    input signed [DATA_WIDTH-1:0] X5,
    input signed [DATA_WIDTH-1:0] X6,
    input signed [DATA_WIDTH-1:0] X7,

    // Output Y: 8x1
    output signed [ACC_WIDTH-1:0] Y0,
    output signed [ACC_WIDTH-1:0] Y1,
    output signed [ACC_WIDTH-1:0] Y2,
    output signed [ACC_WIDTH-1:0] Y3,
    output signed [ACC_WIDTH-1:0] Y4,
    output signed [ACC_WIDTH-1:0] Y5,
    output signed [ACC_WIDTH-1:0] Y6,
    output signed [ACC_WIDTH-1:0] Y7
);

    // =========================================================
    // 64 MULTIPLIERS
    // =========================================================

    // Row 0
    wire signed [2*DATA_WIDTH-1:0] M00 = A00 * X0;
    wire signed [2*DATA_WIDTH-1:0] M01 = A01 * X1;
    wire signed [2*DATA_WIDTH-1:0] M02 = A02 * X2;
    wire signed [2*DATA_WIDTH-1:0] M03 = A03 * X3;
    wire signed [2*DATA_WIDTH-1:0] M04 = A04 * X4;
    wire signed [2*DATA_WIDTH-1:0] M05 = A05 * X5;
    wire signed [2*DATA_WIDTH-1:0] M06 = A06 * X6;
    wire signed [2*DATA_WIDTH-1:0] M07 = A07 * X7;

    // Row 1
    wire signed [2*DATA_WIDTH-1:0] M10 = A10 * X0;
    wire signed [2*DATA_WIDTH-1:0] M11 = A11 * X1;
    wire signed [2*DATA_WIDTH-1:0] M12 = A12 * X2;
    wire signed [2*DATA_WIDTH-1:0] M13 = A13 * X3;
    wire signed [2*DATA_WIDTH-1:0] M14 = A14 * X4;
    wire signed [2*DATA_WIDTH-1:0] M15 = A15 * X5;
    wire signed [2*DATA_WIDTH-1:0] M16 = A16 * X6;
    wire signed [2*DATA_WIDTH-1:0] M17 = A17 * X7;

    // Row 2
    wire signed [2*DATA_WIDTH-1:0] M20 = A20 * X0;
    wire signed [2*DATA_WIDTH-1:0] M21 = A21 * X1;
    wire signed [2*DATA_WIDTH-1:0] M22 = A22 * X2;
    wire signed [2*DATA_WIDTH-1:0] M23 = A23 * X3;
    wire signed [2*DATA_WIDTH-1:0] M24 = A24 * X4;
    wire signed [2*DATA_WIDTH-1:0] M25 = A25 * X5;
    wire signed [2*DATA_WIDTH-1:0] M26 = A26 * X6;
    wire signed [2*DATA_WIDTH-1:0] M27 = A27 * X7;

    // Row 3
    wire signed [2*DATA_WIDTH-1:0] M30 = A30 * X0;
    wire signed [2*DATA_WIDTH-1:0] M31 = A31 * X1;
    wire signed [2*DATA_WIDTH-1:0] M32 = A32 * X2;
    wire signed [2*DATA_WIDTH-1:0] M33 = A33 * X3;
    wire signed [2*DATA_WIDTH-1:0] M34 = A34 * X4;
    wire signed [2*DATA_WIDTH-1:0] M35 = A35 * X5;
    wire signed [2*DATA_WIDTH-1:0] M36 = A36 * X6;
    wire signed [2*DATA_WIDTH-1:0] M37 = A37 * X7;

    // Row 4
    wire signed [2*DATA_WIDTH-1:0] M40 = A40 * X0;
    wire signed [2*DATA_WIDTH-1:0] M41 = A41 * X1;
    wire signed [2*DATA_WIDTH-1:0] M42 = A42 * X2;
    wire signed [2*DATA_WIDTH-1:0] M43 = A43 * X3;
    wire signed [2*DATA_WIDTH-1:0] M44 = A44 * X4;
    wire signed [2*DATA_WIDTH-1:0] M45 = A45 * X5;
    wire signed [2*DATA_WIDTH-1:0] M46 = A46 * X6;
    wire signed [2*DATA_WIDTH-1:0] M47 = A47 * X7;

    // Row 5
    wire signed [2*DATA_WIDTH-1:0] M50 = A50 * X0;
    wire signed [2*DATA_WIDTH-1:0] M51 = A51 * X1;
    wire signed [2*DATA_WIDTH-1:0] M52 = A52 * X2;
    wire signed [2*DATA_WIDTH-1:0] M53 = A53 * X3;
    wire signed [2*DATA_WIDTH-1:0] M54 = A54 * X4;
    wire signed [2*DATA_WIDTH-1:0] M55 = A55 * X5;
    wire signed [2*DATA_WIDTH-1:0] M56 = A56 * X6;
    wire signed [2*DATA_WIDTH-1:0] M57 = A57 * X7;

    // Row 6
    wire signed [2*DATA_WIDTH-1:0] M60 = A60 * X0;
    wire signed [2*DATA_WIDTH-1:0] M61 = A61 * X1;
    wire signed [2*DATA_WIDTH-1:0] M62 = A62 * X2;
    wire signed [2*DATA_WIDTH-1:0] M63 = A63 * X3;
    wire signed [2*DATA_WIDTH-1:0] M64 = A64 * X4;
    wire signed [2*DATA_WIDTH-1:0] M65 = A65 * X5;
    wire signed [2*DATA_WIDTH-1:0] M66 = A66 * X6;
    wire signed [2*DATA_WIDTH-1:0] M67 = A67 * X7;

    // Row 7
    wire signed [2*DATA_WIDTH-1:0] M70 = A70 * X0;
    wire signed [2*DATA_WIDTH-1:0] M71 = A71 * X1;
    wire signed [2*DATA_WIDTH-1:0] M72 = A72 * X2;
    wire signed [2*DATA_WIDTH-1:0] M73 = A73 * X3;
    wire signed [2*DATA_WIDTH-1:0] M74 = A74 * X4;
    wire signed [2*DATA_WIDTH-1:0] M75 = A75 * X5;
    wire signed [2*DATA_WIDTH-1:0] M76 = A76 * X6;
    wire signed [2*DATA_WIDTH-1:0] M77 = A77 * X7;


    // =========================================================
    // ADDER TREE
    // =========================================================

    // ---------------- ROW 0 ----------------
    wire signed [ACC_WIDTH-1:0] S00 = M00 + M01;
    wire signed [ACC_WIDTH-1:0] S01 = M02 + M03;
    wire signed [ACC_WIDTH-1:0] S02 = M04 + M05;
    wire signed [ACC_WIDTH-1:0] S03 = M06 + M07;

    wire signed [ACC_WIDTH-1:0] S04 = S00 + S01;
    wire signed [ACC_WIDTH-1:0] S05 = S02 + S03;

    assign Y0 = S04 + S05;


    // ---------------- ROW 1 ----------------
    wire signed [ACC_WIDTH-1:0] S10 = M10 + M11;
    wire signed [ACC_WIDTH-1:0] S11 = M12 + M13;
    wire signed [ACC_WIDTH-1:0] S12 = M14 + M15;
    wire signed [ACC_WIDTH-1:0] S13 = M16 + M17;

    wire signed [ACC_WIDTH-1:0] S14 = S10 + S11;
    wire signed [ACC_WIDTH-1:0] S15 = S12 + S13;

    assign Y1 = S14 + S15;


    // ---------------- ROW 2 ----------------
    wire signed [ACC_WIDTH-1:0] S20 = M20 + M21;
    wire signed [ACC_WIDTH-1:0] S21 = M22 + M23;
    wire signed [ACC_WIDTH-1:0] S22 = M24 + M25;
    wire signed [ACC_WIDTH-1:0] S23 = M26 + M27;

    wire signed [ACC_WIDTH-1:0] S24 = S20 + S21;
    wire signed [ACC_WIDTH-1:0] S25 = S22 + S23;

    assign Y2 = S24 + S25;


    // ---------------- ROW 3 ----------------
    wire signed [ACC_WIDTH-1:0] S30 = M30 + M31;
    wire signed [ACC_WIDTH-1:0] S31 = M32 + M33;
    wire signed [ACC_WIDTH-1:0] S32 = M34 + M35;
    wire signed [ACC_WIDTH-1:0] S33 = M36 + M37;

    wire signed [ACC_WIDTH-1:0] S34 = S30 + S31;
    wire signed [ACC_WIDTH-1:0] S35 = S32 + S33;

    assign Y3 = S34 + S35;


    // ---------------- ROW 4 ----------------
    wire signed [ACC_WIDTH-1:0] S40 = M40 + M41;
    wire signed [ACC_WIDTH-1:0] S41 = M42 + M43;
    wire signed [ACC_WIDTH-1:0] S42 = M44 + M45;
    wire signed [ACC_WIDTH-1:0] S43 = M46 + M47;

    wire signed [ACC_WIDTH-1:0] S44 = S40 + S41;
    wire signed [ACC_WIDTH-1:0] S45 = S42 + S43;

    assign Y4 = S44 + S45;


    // ---------------- ROW 5 ----------------
    wire signed [ACC_WIDTH-1:0] S50 = M50 + M51;
    wire signed [ACC_WIDTH-1:0] S51 = M52 + M53;
    wire signed [ACC_WIDTH-1:0] S52 = M54 + M55;
    wire signed [ACC_WIDTH-1:0] S53 = M56 + M57;

    wire signed [ACC_WIDTH-1:0] S54 = S50 + S51;
    wire signed [ACC_WIDTH-1:0] S55 = S52 + S53;

    assign Y5 = S54 + S55;


    // ---------------- ROW 6 ----------------
    wire signed [ACC_WIDTH-1:0] S60 = M60 + M61;
    wire signed [ACC_WIDTH-1:0] S61 = M62 + M63;
    wire signed [ACC_WIDTH-1:0] S62 = M64 + M65;
    wire signed [ACC_WIDTH-1:0] S63 = M66 + M67;

    wire signed [ACC_WIDTH-1:0] S64 = S60 + S61;
    wire signed [ACC_WIDTH-1:0] S65 = S62 + S63;

    assign Y6 = S64 + S65;


    // ---------------- ROW 7 ----------------
    wire signed [ACC_WIDTH-1:0] S70 = M70 + M71;
    wire signed [ACC_WIDTH-1:0] S71 = M72 + M73;
    wire signed [ACC_WIDTH-1:0] S72 = M74 + M75;
    wire signed [ACC_WIDTH-1:0] S73 = M76 + M77;

    wire signed [ACC_WIDTH-1:0] S74 = S70 + S71;
    wire signed [ACC_WIDTH-1:0] S75 = S72 + S73;

    assign Y7 = S74 + S75;

endmodule