//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class defines the variables required for an execute_out
//    transaction.  Class variables to be displayed in waveform transaction
//    viewing are added to the transaction viewing stream in the add_to_wave
//    function.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class execute_out_transaction  extends uvmf_transaction_base;

  `uvm_object_utils( execute_out_transaction )

  bit Mem_Control_out ;
  bit [1:0] W_Control_out ;
  bit [15:0] pcout ;
  bit [15:0] aluout ;
  bit [2:0] dr ;
  bit [2:0] sr1 ;
  bit [2:0] sr2 ;
  bit [15:0] IR_Exec ;
  bit [2:0] NZP ;
  bit [15:0] M_Data ;

  //Constraints for the transaction variables:

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  //*******************************************************************
  //*******************************************************************
  // Macros that define structs and associated functions are
  // located in execute_out_macros.svh

  //*******************************************************************
  // Monitor macro used by execute_out_monitor and execute_out_monitor_bfm
  // This struct is defined in execute_out_macros.svh
  `execute_out_MONITOR_STRUCT
    execute_out_monitor_s execute_out_monitor_struct;
  //*******************************************************************
  // FUNCTION: to_monitor_struct()
  // This function packs transaction variables into a execute_out_monitor_s
  // structure.  The function returns the handle to the execute_out_monitor_struct.
  // This function is defined in execute_out_macros.svh
  `execute_out_TO_MONITOR_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_monitor_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in execute_out_macros.svh
  `execute_out_FROM_MONITOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Initiator macro used by execute_out_driver and execute_out_driver_bfm
  // to communicate initiator driven data to execute_out_driver_bfm.
  // This struct is defined in execute_out_macros.svh
  `execute_out_INITIATOR_STRUCT
    execute_out_initiator_s execute_out_initiator_struct;
  //*******************************************************************
  // FUNCTION: to_initiator_struct()
  // This function packs transaction variables into a execute_out_initiator_s
  // structure.  The function returns the handle to the execute_out_initiator_struct.
  // This function is defined in execute_out_macros.svh
  `execute_out_TO_INITIATOR_STRUCT_FUNCTION  
  //*******************************************************************
  // FUNCTION: from_initiator_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in execute_out_macros.svh
  `execute_out_FROM_INITIATOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Responder macro used by execute_out_driver and execute_out_driver_bfm
  // to communicate Responder driven data to execute_out_driver_bfm.
  // This struct is defined in execute_out_macros.svh
  `execute_out_RESPONDER_STRUCT
    execute_out_responder_s execute_out_responder_struct;
  //*******************************************************************
  // FUNCTION: to_responder_struct()
  // This function packs transaction variables into a execute_out_responder_s
  // structure.  The function returns the handle to the execute_out_responder_struct.
  // This function is defined in execute_out_macros.svh
  `execute_out_TO_RESPONDER_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_responder_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in execute_out_macros.svh
  `execute_out_FROM_RESPONDER_STRUCT_FUNCTION 
  // ****************************************************************************
  // FUNCTION : new()
  // This function is the standard SystemVerilog constructor.
  //
  function new( string name = "" );
    super.new( name );
  endfunction

  // ****************************************************************************
  // FUNCTION: convert2string()
  // This function converts all variables in this class to a single string for 
  // logfile reporting.
  //
  virtual function string convert2string();
    // pragma uvmf custom convert2string begin
    // UVMF_CHANGE_ME : Customize format if desired.
    return $sformatf("Mem_Control_out:0x%x W_Control_out:0x%x pcout:0x%x aluout:0x%x dr:0x%x sr1:0x%x sr2:0x%x IR_Exec:0x%x NZP:0x%x M_Data:0x%x ",Mem_Control_out,W_Control_out,pcout,aluout,dr,sr1,sr2,IR_Exec,NZP,M_Data);
    // pragma uvmf custom convert2string end
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
    execute_out_transaction  RHS;
    if (!$cast(RHS,rhs)) return 0;
    // pragma uvmf custom do_compare begin
    // UVMF_CHANGE_ME : Eliminate comparison of variables not to be used for compare
    return (super.do_compare(rhs,comparer)
            &&(this.Mem_Control_out == RHS.Mem_Control_out)
            &&(this.W_Control_out == RHS.W_Control_out)
            &&(this.pcout == RHS.pcout)
            &&(this.aluout == RHS.aluout)
            &&(this.dr == RHS.dr)
            &&(this.sr1 == RHS.sr1)
            &&(this.sr2 == RHS.sr2)
            &&(this.IR_Exec == RHS.IR_Exec)
            &&(this.NZP == RHS.NZP)
            &&(this.M_Data == RHS.M_Data)
            );
    // pragma uvmf custom do_compare end
  endfunction

  //*******************************************************************
  // FUNCTION: do_copy()
  // This function is automatically called when the .copy() function
  // is called on this class.
  //
  virtual function void do_copy (uvm_object rhs);
    execute_out_transaction  RHS;
    if(!$cast(RHS,rhs))begin
      `uvm_fatal("CAST","Transaction cast in do_copy() failed!")
    end
    // pragma uvmf custom do_copy begin
    super.do_copy(rhs);
    this.Mem_Control_out = RHS.Mem_Control_out;
    this.W_Control_out = RHS.W_Control_out;
    this.pcout = RHS.pcout;
    this.aluout = RHS.aluout;
    this.dr = RHS.dr;
    this.sr1 = RHS.sr1;
    this.sr2 = RHS.sr2;
    this.IR_Exec = RHS.IR_Exec;
    this.NZP = RHS.NZP;
    this.M_Data = RHS.M_Data;
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
      transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"execute_out_transaction",start_time);
    end
    super.add_to_wave(transaction_view_h);
    // pragma uvmf custom add_to_wave begin
    // UVMF_CHANGE_ME : Color can be applied to transaction entries based on content, example below
    // case()
    //   1 : $add_color(transaction_view_h,"red");
    //   default : $add_color(transaction_view_h,"grey");
    // endcase
    // UVMF_CHANGE_ME : Eliminate transaction variables not wanted in transaction viewing in the waveform viewer
    $add_attribute(transaction_view_h,Mem_Control_out,"Mem_Control_out");
    $add_attribute(transaction_view_h,W_Control_out,"W_Control_out");
    $add_attribute(transaction_view_h,pcout,"pcout");
    $add_attribute(transaction_view_h,aluout,"aluout");
    $add_attribute(transaction_view_h,dr,"dr");
    $add_attribute(transaction_view_h,sr1,"sr1");
    $add_attribute(transaction_view_h,sr2,"sr2");
    $add_attribute(transaction_view_h,IR_Exec,"IR_Exec");
    $add_attribute(transaction_view_h,NZP,"NZP");
    $add_attribute(transaction_view_h,M_Data,"M_Data");
    // pragma uvmf custom add_to_wave end
    $end_transaction(transaction_view_h,end_time);
    $free_transaction(transaction_view_h);
    `endif // QUESTA
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

