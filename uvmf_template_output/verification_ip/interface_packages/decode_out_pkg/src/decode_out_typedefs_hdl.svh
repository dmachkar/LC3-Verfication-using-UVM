//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
// This file contains defines and typedefs to be compiled for use in
// the simulation running on the emulator when using Veloce.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
                                                                               

typedef enum bit [3:0] {BR=4'b0000, ADD=4'b0001, LD=4'b0010, ST=4'b0011, AND=4'b0101, LDR=4'b0110, STR=4'b0111, NOT=4'b1001, LDI=4'b1010, STI=4'b1011, JMP=4'b1100, LEA=4'b1110} op_t;

// pragma uvmf custom additional begin
// pragma uvmf custom additional end

