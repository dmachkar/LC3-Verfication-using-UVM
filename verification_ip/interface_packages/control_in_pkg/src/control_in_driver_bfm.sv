//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
//    This interface performs the control_in signal driving.  It is
//     accessed by the uvm control_in driver through a virtual interface
//     handle in the control_in configuration.  It drives the singals passed
//     in through the port connection named bus of type control_in_if.
//
//     Input signals from the control_in_if are assigned to an internal input
//     signal with a _i suffix.  The _i signal should be used for sampling.
//
//     The input signal connections are as follows:
//       bus.signal -> signal_i 
//
//     This bfm drives signals with a _o suffix.  These signals
//     are driven onto signals within control_in_if based on INITIATOR/RESPONDER and/or
//     ARBITRATION/GRANT status.  
//
//     The output signal connections are as follows:
//        signal_o -> bus.signal
//
//                                                                                           
//      Interface functions and tasks used by UVM components:
//
//             configure:
//                   This function gets configuration attributes from the
//                   UVM driver to set any required BFM configuration
//                   variables such as 'initiator_responder'.                                       
//                                                                                           
//             initiate_and_get_response:
//                   This task is used to perform signaling activity for initiating
//                   a protocol transfer.  The task initiates the transfer, using
//                   input data from the initiator struct.  Then the task captures
//                   response data, placing the data into the response struct.
//                   The response struct is returned to the driver class.
//
//             respond_and_wait_for_next_transfer:
//                   This task is used to complete a current transfer as a responder
//                   and then wait for the initiator to start the next transfer.
//                   The task uses data in the responder struct to drive protocol
//                   signals to complete the transfer.  The task then waits for 
//                   the next transfer.  Once the next transfer begins, data from
//                   the initiator is placed into the initiator struct and sent
//                   to the responder sequence for processing to determine 
//                   what data to respond with.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
import uvmf_base_pkg_hdl::*;
import control_in_pkg_hdl::*;
`include "src/control_in_macros.svh"

interface control_in_driver_bfm 
  (control_in_if bus);
  // The following pragma and additional ones in-lined further below are for running this BFM on Veloce
  // pragma attribute control_in_driver_bfm partition_interface_xif

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

  // Config value to determine if this is an initiator or a responder 
  uvmf_initiator_responder_t initiator_responder;
  // Custom configuration variables.  
  // These are set using the configure function which is called during the UVM connect_phase

  tri clock_i;
  tri reset_i;

  // Signal list (all signals are capable of being inputs and outputs for the sake
  // of supporting both INITIATOR and RESPONDER mode operation. Expectation is that 
  // directionality in the config file was from the point-of-view of the INITIATOR

  // INITIATOR mode input signals

  // INITIATOR mode output signals
  tri  complete_data_i;
  reg  complete_data_o = 'bz;
  tri  complete_instr_i;
  reg  complete_instr_o = 'bz;
  tri [15:0] IR_i;
  reg  IR_o = 'bz;
  tri [2:0] NZP_i;
  reg [2:0] NZP_o = 'bz;
  tri [2:0] psr_i;
  reg [2:0] psr_o = 'bz;
  tri [15:0] IR_Exec_i;
  reg [15:0] IR_Exec_o = 'bz;
  tri [15:0] IMem_dout_i;
  reg [15:0] IMem_dout_o = 'bz;

  // Bi-directional signals
  

  assign clock_i = bus.clock;
  assign reset_i = bus.reset;

  // These are signals marked as 'input' by the config file, but the signals will be
  // driven by this BFM if put into RESPONDER mode (flipping all signal directions around)


  // These are signals marked as 'output' by the config file, but the outputs will
  // not be driven by this BFM unless placed in INITIATOR mode.
  assign bus.complete_data = (initiator_responder == INITIATOR) ? complete_data_o : 'bz;
  assign complete_data_i = bus.complete_data;
  assign bus.complete_instr = (initiator_responder == INITIATOR) ? complete_instr_o : 'bz;
  assign complete_instr_i = bus.complete_instr;
  assign bus.IR = (initiator_responder == INITIATOR) ? IR_o : 'bz;
  assign IR_i = bus.IR;
  assign bus.NZP = (initiator_responder == INITIATOR) ? NZP_o : 'bz;
  assign NZP_i = bus.NZP;
  assign bus.psr = (initiator_responder == INITIATOR) ? psr_o : 'bz;
  assign psr_i = bus.psr;
  assign bus.IR_Exec = (initiator_responder == INITIATOR) ? IR_Exec_o : 'bz;
  assign IR_Exec_i = bus.IR_Exec;
  assign bus.IMem_dout = (initiator_responder == INITIATOR) ? IMem_dout_o : 'bz;
  assign IMem_dout_i = bus.IMem_dout;

  // Proxy handle to UVM driver
  control_in_pkg::control_in_driver   proxy;
  // pragma tbx oneway proxy.my_function_name_in_uvm_driver                 

  // ****************************************************************************
  // **************************************************************************** 
  // Macros that define structs located in control_in_macros.svh
  // ****************************************************************************
  // Struct for passing configuration data from control_in_driver to this BFM
  // ****************************************************************************
  `control_in_CONFIGURATION_STRUCT
  // ****************************************************************************
  // Structs for INITIATOR and RESPONDER data flow
  //*******************************************************************
  // Initiator macro used by control_in_driver and control_in_driver_bfm
  // to communicate initiator driven data to control_in_driver_bfm.           
  `control_in_INITIATOR_STRUCT
    control_in_initiator_s initiator_struct;
  // Responder macro used by control_in_driver and control_in_driver_bfm
  // to communicate Responder driven data to control_in_driver_bfm.
  `control_in_RESPONDER_STRUCT
    control_in_responder_s responder_struct;

  // ****************************************************************************
// pragma uvmf custom reset_condition_and_response begin
  // Always block used to return signals to reset value upon assertion of reset
  always @( posedge reset_i )
     begin
       // RESPONDER mode output signals
       // INITIATOR mode output signals
       complete_data_o <= 'bz;
       complete_instr_o <= 'bz;
       IR_o <= 'bz;
       NZP_o <= 'bz;
       psr_o <= 'bz;
       IR_Exec_o <= 'bz;
       IMem_dout_o <= 'bz;
       // Bi-directional signals
 
     end    
// pragma uvmf custom reset_condition_and_response end

  // pragma uvmf custom interface_item_additional begin
  // pragma uvmf custom interface_item_additional end

  //******************************************************************
  // The configure() function is used to pass agent configuration
  // variables to the driver BFM.  It is called by the driver within
  // the agent at the beginning of the simulation.  It may be called 
  // during the simulation if agent configuration variables are updated
  // and the driver BFM needs to be aware of the new configuration 
  // variables.
  //

  function void configure(control_in_configuration_s control_in_configuration_arg); // pragma tbx xtf  
    initiator_responder = control_in_configuration_arg.initiator_responder;
  // pragma uvmf custom configure begin
  // pragma uvmf custom configure end
  endfunction                                                                             

// pragma uvmf custom initiate_and_get_response begin
// ****************************************************************************
// UVMF_CHANGE_ME
// This task is used by an initator.  The task first initiates a transfer then
// waits for the responder to complete the transfer.
    task initiate_and_get_response( 
       // This argument passes transaction variables used by an initiator
       // to perform the initial part of a protocol transfer.  The values
       // come from a sequence item created in a sequence.
       input control_in_initiator_s control_in_initiator_struct, 
       // This argument is used to send data received from the responder
       // back to the sequence item.  The sequence item is returned to the sequence.
       output control_in_responder_s control_in_responder_struct 
       );// pragma tbx xtf  
       // 
       // Members within the control_in_initiator_struct:
       //   bit complete_data ;
       //   bit complete_instr ;
       //   bit IR ;
       //   bit [2:0] NZP ;
       //   bit [2:0] psr ;
       //   bit [15:0] IR_Exec ;
       //   bit [15:0] IMem_dout ;
       // Members within the control_in_responder_struct:
       //   bit complete_data ;
       //   bit complete_instr ;
       //   bit IR ;
       //   bit [2:0] NZP ;
       //   bit [2:0] psr ;
       //   bit [15:0] IR_Exec ;
       //   bit [15:0] IMem_dout ;
       initiator_struct = control_in_initiator_struct;
       //
       // Reference code;
       //    How to wait for signal value
       //      while (control_signal == 1'b1) @(posedge clock_i);
       //    
       //    How to assign a responder struct member, named xyz, from a signal.   
       //    All available initiator input and inout signals listed.
       //    Initiator input signals
       //    Initiator inout signals
       //    How to assign a signal from an initiator struct member named xyz.   
       //    All available initiator output and inout signals listed.
       //    Notice the _o.  Those are storage variables that allow for procedural assignment.
       //    Initiator output signals
       //      complete_data_o <= control_in_initiator_struct.xyz;  //     
       //      complete_instr_o <= control_in_initiator_struct.xyz;  //     
       //      IR_o <= control_in_initiator_struct.xyz;  //     
       //      NZP_o <= control_in_initiator_struct.xyz;  //    [2:0] 
       //      psr_o <= control_in_initiator_struct.xyz;  //    [2:0] 
       //      IR_Exec_o <= control_in_initiator_struct.xyz;  //    [15:0] 
       //      IMem_dout_o <= control_in_initiator_struct.xyz;  //    [15:0] 
       //    Initiator inout signals
    // Initiate a transfer using the data received.
    @(posedge clock_i);
    @(posedge clock_i);
    // Wait for the responder to complete the transfer then place the responder data into 
    // control_in_responder_struct.
    @(posedge clock_i);
    @(posedge clock_i);
    responder_struct = control_in_responder_struct;
  endtask        
// pragma uvmf custom initiate_and_get_response end

// pragma uvmf custom respond_and_wait_for_next_transfer begin
// ****************************************************************************
// The first_transfer variable is used to prevent completing a transfer in the 
// first call to this task.  For the first call to this task, there is not
// current transfer to complete.
bit first_transfer=1;

// UVMF_CHANGE_ME
// This task is used by a responder.  The task first completes the current 
// transfer in progress then waits for the initiator to start the next transfer.
  task respond_and_wait_for_next_transfer( 
       // This argument is used to send data received from the initiator
       // back to the sequence item.  The sequence determines how to respond.
       output control_in_initiator_s control_in_initiator_struct, 
       // This argument passes transaction variables used by a responder
       // to complete a protocol transfer.  The values come from a sequence item.       
       input control_in_responder_s control_in_responder_struct 
       );// pragma tbx xtf   
  // Variables within the control_in_initiator_struct:
  //   bit complete_data ;
  //   bit complete_instr ;
  //   bit IR ;
  //   bit [2:0] NZP ;
  //   bit [2:0] psr ;
  //   bit [15:0] IR_Exec ;
  //   bit [15:0] IMem_dout ;
  // Variables within the control_in_responder_struct:
  //   bit complete_data ;
  //   bit complete_instr ;
  //   bit IR ;
  //   bit [2:0] NZP ;
  //   bit [2:0] psr ;
  //   bit [15:0] IR_Exec ;
  //   bit [15:0] IMem_dout ;
       // Reference code;
       //    How to wait for signal value
       //      while (control_signal == 1'b1) @(posedge clock_i);
       //    
       //    How to assign a initiator struct member, named xyz, from a signal.   
       //    All available responder input and inout signals listed.
       //    Responder input signals
       //      control_in_initiator_struct.xyz = complete_data_i;  //     
       //      control_in_initiator_struct.xyz = complete_instr_i;  //     
       //      control_in_initiator_struct.xyz = IR_i;  //     
       //      control_in_initiator_struct.xyz = NZP_i;  //    [2:0] 
       //      control_in_initiator_struct.xyz = psr_i;  //    [2:0] 
       //      control_in_initiator_struct.xyz = IR_Exec_i;  //    [15:0] 
       //      control_in_initiator_struct.xyz = IMem_dout_i;  //    [15:0] 
       //    Responder inout signals
       //    How to assign a signal, named xyz, from an responder struct member.   
       //    All available responder output and inout signals listed.
       //    Notice the _o.  Those are storage variables that allow for procedural assignment.
       //    Responder output signals
       //    Responder inout signals
    
  @(posedge clock_i);
  if (!first_transfer) begin
    // Perform transfer response here.   
    // Reply using data recieved in the control_in_responder_struct.
    @(posedge clock_i);
    // Reply using data recieved in the transaction handle.
    @(posedge clock_i);
  end
    // Wait for next transfer then gather info from intiator about the transfer.
    // Place the data into the control_in_initiator_struct.
    @(posedge clock_i);
    @(posedge clock_i);
    first_transfer = 0;
  endtask
// pragma uvmf custom respond_and_wait_for_next_transfer end

 
endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

