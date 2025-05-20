//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class defines the variables required for an imem
//    transaction.  Class variables to be displayed in waveform transaction
//    viewing are added to the transaction viewing stream in the add_to_wave
//    function.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class imem_transaction  extends uvmf_transaction_base;

  `uvm_object_utils( imem_transaction )

  
  randc opcode op ;
  rand bit [2:0] DR ;
  rand bit [2:0] SR1 ;
  rand bit [2:0] SR2 ;
  rand bit [2:0] SR ;
  rand bit [4:0] IMM5 ;
  rand bit [2:0] BaseR ;
  rand bit [5:0] PCoffset6 ;
  rand bit [8:0] PCoffset9 ;
  randc bit [2:0] NZP ;
  bit [15:0] NPC ;
  rand bit [15:0] instr_dout ;
  randc bit IR5;
  bit instrmem_rd ;
  bit complete_instr ;
  bit notNullInst;

  //Constraints for the transaction variables:
    constraint nzp_not_zero { NZP!=3'b000;}     
    constraint valid_instruction {op inside {ADD, AND, NOT, LD, LDR, LDI, LEA, ST, STI, STR, BR, JMP};}
  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  //*******************************************************************
  //*******************************************************************
  // Macros that define structs and associated functions are
  // located in imem_macros.svh

  //*******************************************************************
  // Monitor macro used by imem_monitor and imem_monitor_bfm
  // This struct is defined in imem_macros.svh
  `imem_MONITOR_STRUCT
    imem_monitor_s imem_monitor_struct;
  //*******************************************************************
  // FUNCTION: to_monitor_struct()
  // This function packs transaction variables into a imem_monitor_s
  // structure.  The function returns the handle to the imem_monitor_struct.
  // This function is defined in imem_macros.svh
  `imem_TO_MONITOR_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_monitor_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in imem_macros.svh
  `imem_FROM_MONITOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Initiator macro used by imem_driver and imem_driver_bfm
  // to communicate initiator driven data to imem_driver_bfm.
  // This struct is defined in imem_macros.svh
  `imem_INITIATOR_STRUCT
    imem_initiator_s imem_initiator_struct;
  //*******************************************************************
  // FUNCTION: to_initiator_struct()
  // This function packs transaction variables into a imem_initiator_s
  // structure.  The function returns the handle to the imem_initiator_struct.
  // This function is defined in imem_macros.svh
  `imem_TO_INITIATOR_STRUCT_FUNCTION  
  //*******************************************************************
  // FUNCTION: from_initiator_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in imem_macros.svh
  `imem_FROM_INITIATOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Responder macro used by imem_driver and imem_driver_bfm
  // to communicate Responder driven data to imem_driver_bfm.
  // This struct is defined in imem_macros.svh
  `imem_RESPONDER_STRUCT
    imem_responder_s imem_responder_struct;
  //*******************************************************************
  // FUNCTION: to_responder_struct()
  // This function packs transaction variables into a imem_responder_s
  // structure.  The function returns the handle to the imem_responder_struct.
  // This function is defined in imem_macros.svh
  `imem_TO_RESPONDER_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_responder_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in imem_macros.svh
  `imem_FROM_RESPONDER_STRUCT_FUNCTION 
  // ****************************************************************************
  // FUNCTION : new()
  // This function is the standard SystemVerilog constructor.
  //
  function new( string name = "" );
    super.new( name );
    notNullInst=0;
  endfunction

  // ****************************************************************************
  // FUNCTION: convert2string()
  // This function converts all variables in this class to a single string for 
  // logfile reporting.
  //
  virtual function string convert2string();
    // pragma uvmf custom convert2string begin
    // UVMF_CHANGE_ME : Customize format if desired.
    return $sformatf("op:0x%x DR:0x%x SR1:0x%x SR2:0x%x SR:0x%x IMM5:0x%x BaseR:0x%x PCoffset6:0x%x PCoffset9:0x%x NZP:0x%x NPC:0x%x instr_dout:0x%x instrmem_rd:0x%x complete_instr:0x%x ",op,DR,SR1,SR2,SR,IMM5,BaseR,PCoffset6,PCoffset9,NZP,NPC,instr_dout,instrmem_rd,complete_instr);
    // pragma uvmf custom convert2string end
  endfunction


  function string printInstr();
        string result="";
        case(op)
            ADD:begin
                    if(IR5) result=$sformatf(" Type = ADD | DR = %x | SR1 = %x | IMM5 = %x |", DR, SR1, IMM5);
                    else result=$sformatf(" Type = ADD | DR = %x | SR1 = %x | SR2 = %x |", DR, SR1, SR2);
                end
            AND:begin
                    if(IR5) result=$sformatf(" Type = AND | DR = %x | SR1 = %x | IMM5 = %x |", DR, SR1, IMM5);
                    else result=$sformatf(" Type = AND | DR = %x | SR1 = %x | SR2 = %x |", DR, SR1, SR2);
                end
            NOT:begin
                    result=$sformatf(" Type = NOT | DR= %x | SR1 = %x |", DR, SR1);
                end
            LD:begin
                    result=$sformatf(" Type = LD  | DR= %x | PCoffset = %x |", DR, PCoffset9);
                end
            LDR:begin
                    result=$sformatf(" Type = LDR | DR = %x | BaseR = %x | PCoffset = %x |", DR, BaseR, PCoffset6);
                end
            LDI:begin
                    result=$sformatf(" Type = LDI | DR = %x | PCoffset = %x |", DR, PCoffset9);
                end
            LEA:begin
                    result=$sformatf(" Type = LEA | DR = %x | PCoffset = %x |", DR, PCoffset9);
                end
            ST:begin
                    result=$sformatf(" Type = ST  | SR = %x | PCoffset = %x |", SR, PCoffset9);
                end
            STR:begin
                    result=$sformatf(" Type = STR | SR = %x | BaseR = %x | PCoffset = %x |", SR, BaseR, PCoffset6);
                end
            STI:begin
                    result=$sformatf(" Type = STI | SR = %x | PCoffset = %x |", SR, PCoffset9);
                end
            BR:begin
                    result=$sformatf(" Type = BR  | NZP = %x | PCoffset = %x |", NZP, PCoffset9);
                end
            JMP:begin
                    result=$sformatf(" Type = JMP | BaseR = %x |",BaseR);
                end
        endcase
        return result;
    endfunction

  function void post_randomize();            
        case(op)
            ADD:begin
                    if(IR5) instr_dout={op,DR,SR1,IR5,IMM5};
                    else instr_dout={op,DR,SR1,IR5,2'b00,SR2};
                end
            AND:begin
                    if(IR5) instr_dout={op,DR,SR1,IR5,IMM5};
                    else instr_dout={op,DR,SR1,IR5,2'b00,SR2};
                end
            NOT:begin
                    instr_dout={op,DR,SR1,6'b111111};
                end
            LD:begin
                    instr_dout={op,DR,PCoffset9};
                end
            LDR:begin
                    instr_dout={op,DR,BaseR,PCoffset6};
                end
            LDI:begin
                    instr_dout={op,DR,PCoffset9};
                end
            LEA:begin
                    instr_dout={op,DR,PCoffset9};
                end
            ST:begin
                    instr_dout={op,SR,PCoffset9};
                end
            STR:begin
                    instr_dout={op,SR,BaseR,PCoffset6};
                end
            STI:begin
                    instr_dout={op,SR,PCoffset9};
                end
            BR: begin 
                    instr_dout={op,NZP,PCoffset9};
                end
            JMP:begin
                    instr_dout={op,3'b000,BaseR,6'b000000};
                end
            default: $error("INSTRUCTION OUT OF SCOPE");
        endcase
    endfunction

      virtual function void set_op(); 
        $cast(op,instr_dout[15:12]);                     
        if(instr_dout!=0) notNullInst=1;        
        case(op)
            ADD, AND:begin
                    DR=instr_dout[11:9];
                    SR1=instr_dout[8:6];
                    IR5=instr_dout[5];
                    if(IR5) begin
                        IMM5=instr_dout[4:0];
                    end else begin
                        SR2=instr_dout[3:0];
                    end
                end
            NOT:begin
                    DR=instr_dout[11:9];
                    SR1=instr_dout[8:6]; 
                end
            LD,LDI,LEA: begin
                    DR=instr_dout[11:9];
                    PCoffset9=instr_dout[8:0];
                end
            LDR:begin
                    DR=instr_dout[11:9];
                    BaseR=instr_dout[8:6];
                    PCoffset6=instr_dout[5:0];
                end             
            ST,STI: begin
                    SR=instr_dout[11:9];
                    PCoffset9=instr_dout[8:0];
                end
            STR:begin
                    SR=instr_dout[11:9];
                    BaseR=instr_dout[8:6];
                    PCoffset6=instr_dout[5:0];
                end 
            BR:begin
                    NZP=instr_dout[11:9];
                    PCoffset9=instr_dout[8:0];
               end
            JMP:begin
                    BaseR=instr_dout[8:6];
               end
        endcase
    endfunction

  //*******************************************************************
  // FUNCTION: do_print()
  // This function is automatically called when the .print() function
  // is called on this class.
  //
  virtual function void do_print(uvm_printer printer);
    // pragma uvmf custom do_print begin
    // UVMF_CHANGE_ME : Current contents of do_print allows for the use of UVM 1.1d, 1.2 or P1800.2.
    // Update based on your own printing preference according to your preferred UVM version
    $display(convert2string());
    // pragma uvmf custom do_print end
  endfunction

  //*******************************************************************
  // FUNCTION: do_compare()
  // This function is automatically called when the .compare() function
  // is called on this class.
  //
  virtual function bit do_compare (uvm_object rhs, uvm_comparer comparer);
    imem_transaction  RHS;
    if (!$cast(RHS,rhs)) return 0;
    // pragma uvmf custom do_compare begin
    // UVMF_CHANGE_ME : Eliminate comparison of variables not to be used for compare
    return (super.do_compare(rhs,comparer)
            &&(this.NPC == RHS.NPC)
            &&(this.instr_dout == RHS.instr_dout)
            );
    // pragma uvmf custom do_compare end
  endfunction

  //*******************************************************************
  // FUNCTION: do_copy()
  // This function is automatically called when the .copy() function
  // is called on this class.
  //
  virtual function void do_copy (uvm_object rhs);
    imem_transaction  RHS;
    if(!$cast(RHS,rhs))begin
      `uvm_fatal("CAST","Transaction cast in do_copy() failed!")
    end
    // pragma uvmf custom do_copy begin
    super.do_copy(rhs);
    this.op = RHS.op;
    this.DR = RHS.DR;
    this.SR1 = RHS.SR1;
    this.SR2 = RHS.SR2;
    this.SR = RHS.SR;
    this.IMM5 = RHS.IMM5;
    this.BaseR = RHS.BaseR;
    this.PCoffset6 = RHS.PCoffset6;
    this.PCoffset9 = RHS.PCoffset9;
    this.NZP = RHS.NZP;
    this.NPC = RHS.NPC;
    this.instr_dout = RHS.instr_dout;
    this.instrmem_rd = RHS.instrmem_rd;
    this.complete_instr = RHS.complete_instr;
    // pragma uvmf custom do_copy end
  endfunction

  // ****************************************************************************
  // FUNCTION: add_to_wave()
  // This function is used to display variables in this class in the waveform 
  // viewer.  The start_time and end_time variables must be set before this 
  // function is called.  If the start_time and end_time variables are not set
  // the transaction will be hidden at 0ns on the waveform display.
  // 
  virtual function void add_to_wave(int transaction_viewing_stream_h);
    `ifdef QUESTA
    if (transaction_view_h == 0) begin
      transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"imem_transaction",start_time);
    end
    super.add_to_wave(transaction_view_h);
    // pragma uvmf custom add_to_wave begin
    // UVMF_CHANGE_ME : Color can be applied to transaction entries based on content, example below
    // case()
    //   1 : $add_color(transaction_view_h,"red");
    //   default : $add_color(transaction_view_h,"grey");
    // endcase
    // UVMF_CHANGE_ME : Eliminate transaction variables not wanted in transaction viewing in the waveform viewer
    $add_attribute(transaction_view_h,op,"op");
    $add_attribute(transaction_view_h,DR,"DR");
    $add_attribute(transaction_view_h,SR1,"SR1");
    $add_attribute(transaction_view_h,SR2,"SR2");
    $add_attribute(transaction_view_h,SR,"SR");
    $add_attribute(transaction_view_h,IMM5,"IMM5");
    $add_attribute(transaction_view_h,BaseR,"BaseR");
    $add_attribute(transaction_view_h,PCoffset6,"PCoffset6");
    $add_attribute(transaction_view_h,PCoffset9,"PCoffset9");
    $add_attribute(transaction_view_h,NZP,"NZP");
    $add_attribute(transaction_view_h,NPC,"NPC");
    $add_attribute(transaction_view_h,instr_dout,"instr_dout");
    $add_attribute(transaction_view_h,instrmem_rd,"instrmem_rd");
    $add_attribute(transaction_view_h,complete_instr,"complete_instr");
    // pragma uvmf custom add_to_wave end
    $end_transaction(transaction_view_h,end_time);
    $free_transaction(transaction_view_h);
    `endif // QUESTA
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

