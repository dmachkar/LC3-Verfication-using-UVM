//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface performs the imem signal monitoring.
//      It is accessed by the uvm imem monitor through a virtual
//      interface handle in the imem configuration.  It monitors the
//      signals passed in through the port connection named bus of
//      type imem_if.
//
//     Input signals from the imem_if are assigned to an internal input
//     signal with a _i suffix.  The _i signal should be used for sampling.
//
//     The input signal connections are as follows:
//       bus.signal -> signal_i 
//
//      Interface functions and tasks used by UVM components:
//             monitor(inout TRANS_T txn);
//                   This task receives the transaction, txn, from the
//                   UVM monitor and then populates variables in txn
//                   from values observed on bus activity.  This task
//                   blocks until an operation on the imem bus is complete.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
import uvmf_base_pkg_hdl::*;
import imem_pkg_hdl::*;
`include "src/imem_macros.svh"


interface imem_monitor_bfm 
  ( imem_if  bus );
  // The pragma below and additional ones in-lined further down are for running this BFM on Veloce
  // pragma attribute imem_monitor_bfm partition_interface_xif                                  

`ifndef XRTL
// This code is to aid in debugging parameter mismatches between the BFM and its corresponding agent.
// Enable this debug by setting UVM_VERBOSITY to UVM_DEBUG
// Setting UVM_VERBOSITY to UVM_DEBUG causes all BFM's and all agents to display their parameter settings.
// All of the messages from this feature have a UVM messaging id value of "CFG"
// The transcript or run.log can be parsed to ensure BFM parameter settings match its corresponding agents parameter settings.
import uvm_pkg::*;
`include "uvm_macros.svh"
initial begin : bfm_vs_agent_parameter_debug
  `uvm_info("CFG", 
      $psprintf("The BFM at '%m' has the following parameters: ", ),
      UVM_DEBUG)
end
`endif


  // Structure used to pass transaction data from monitor BFM to monitor class in agent.
`imem_MONITOR_STRUCT
  imem_monitor_s imem_monitor_struct;

  // Structure used to pass configuration data from monitor class to monitor BFM.
 `imem_CONFIGURATION_STRUCT
 

  // Config value to determine if this is an initiator or a responder 
  uvmf_initiator_responder_t initiator_responder;
  // Custom configuration variables.  
  // These are set using the configure function which is called during the UVM connect_phase

  tri clock_i;
  tri reset_i;
  tri [15:0] PC_i;
  tri  instrmem_rd_i;
  tri [15:0] instr_dout_i;
  tri complete_instr_i;
  tri [15:0] l_macc_i;
  assign clock_i = bus.clock;
  assign reset_i = bus.reset;
  assign PC_i = bus.PC;
  assign instrmem_rd_i = bus.instrmem_rd;
  assign instr_dout_i = bus.instr_dout;
  assign complete_instr_i = bus.complete_instr;
  assign l_macc_i = bus.l_macc;

  // Proxy handle to UVM monitor
  imem_pkg::imem_monitor  proxy;
  // pragma tbx oneway proxy.notify_transaction                 

  // pragma uvmf custom interface_item_additional begin
  // pragma uvmf custom interface_item_additional end
  
  //******************************************************************                         
  task wait_for_reset();// pragma tbx xtf  
    @(posedge clock_i) ;                                                                    
    do_wait_for_reset();                                                                   
  endtask                                                                                   

  // ****************************************************************************              
  task do_wait_for_reset(); 
  // pragma uvmf custom reset_condition begin
    wait ( reset_i === 0 ) ;                                                              
    @(posedge clock_i) ;                                                                    
  // pragma uvmf custom reset_condition end                                                                
  endtask    

  //******************************************************************                         
 
  task wait_for_num_clocks(input int unsigned count); // pragma tbx xtf 
    @(posedge clock_i);  
                                                                   
    repeat (count-1) @(posedge clock_i);                                                    
  endtask      

  //******************************************************************                         
  event go;                                                                                 
  function void start_monitoring();// pragma tbx xtf    
    -> go;
  endfunction                                                                               
  
  // ****************************************************************************              
  initial begin                                                                             
    @go;                                                                                   
    forever begin                                                                        
      @(posedge clock_i);  
      do_monitor( imem_monitor_struct );
                                                                 
 
      proxy.notify_transaction( imem_monitor_struct );
 
    end                                                                                    
  end                                                                                       

  //******************************************************************
  // The configure() function is used to pass agent configuration
  // variables to the monitor BFM.  It is called by the monitor within
  // the agent at the beginning of the simulation.  It may be called 
  // during the simulation if agent configuration variables are updated
  // and the monitor BFM needs to be aware of the new configuration 
  // variables.
  //
    function void configure(imem_configuration_s imem_configuration_arg); // pragma tbx xtf  
    initiator_responder = imem_configuration_arg.initiator_responder;
  // pragma uvmf custom configure begin
  // pragma uvmf custom configure end
  endfunction   


  // ****************************************************************************  
            
  task do_monitor(output imem_monitor_s imem_monitor_struct);
    //
    // Available struct members:
    //     //    imem_monitor_struct.op
    //     //    imem_monitor_struct.DR
    //     //    imem_monitor_struct.SR1
    //     //    imem_monitor_struct.SR2
    //     //    imem_monitor_struct.SR
    //     //    imem_monitor_struct.IMM5
    //     //    imem_monitor_struct.BaseR
    //     //    imem_monitor_struct.PCoffset6
    //     //    imem_monitor_struct.PCoffset9
    //     //    imem_monitor_struct.NZP
    //     //    imem_monitor_struct.NPC
    //     //    imem_monitor_struct.instr_dout
    //     //    imem_monitor_struct.instrmem_rd
    //     //    imem_monitor_struct.complete_instr
    //     //
    // Reference code;
    //    How to wait for signal value
    //      while (control_signal === 1'b1) @(posedge clock_i);
    //    
    //    How to assign a struct member, named xyz, from a signal.   
    //    All available input signals listed.
    //      imem_monitor_struct.xyz = PC_i;  //    [15:0] 
    //      imem_monitor_struct.xyz = instrmem_rd_i;  //     
    //      imem_monitor_struct.xyz = instr_dout_i;  //    [15:0] 
    //      imem_monitor_struct.xyz = complete_instr_i;  //    [15:0] 
    //      imem_monitor_struct.xyz = l_macc_i;  //    [15:0] 
    // pragma uvmf custom do_monitor begin
    // UVMF_CHANGE_ME : Implement protocol monitoring.  The commented reference code 
    // below are examples of how to capture signal values and assign them to 
    // structure members.  All available input signals are listed.  The 'while' 
    // code example shows how to wait for a synchronous flow control signal.  This
    // task should return when a complete transfer has been observed.  Once this task is
    // exited with captured values, it is then called again to wait for and observe 
    // the next transfer. One clock cycle is consumed between calls to do_monitor.
          imem_monitor_struct.NPC <= PC_i;  
         imem_monitor_struct.instrmem_rd <= instrmem_rd_i; 
         imem_monitor_struct.instr_dout <= instr_dout_i;  
         imem_monitor_struct.complete_instr <= complete_instr_i; 

         
    // pragma uvmf custom do_monitor end
  endtask         
  
 
endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

