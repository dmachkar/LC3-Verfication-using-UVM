//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------                     
//               
// Description: This top level module instantiates all synthesizable
//    static content.  This and tb_top.sv are the two top level modules
//    of the simulation.  
//
//    This module instantiates the following:
//        DUT: The Design Under Test
//        Interfaces:  Signal bundles that contain signals connected to DUT
//        Driver BFM's: BFM's that actively drive interface signals
//        Monitor BFM's: BFM's that passively monitor interface signals
//
//----------------------------------------------------------------------

//----------------------------------------------------------------------
//

module hdl_top;

import lc3_parameters_pkg::*;
import uvmf_base_pkg_hdl::*;


// tri	clock, reset;
tri	complete_instr, complete_data;
tri	[15:0] 	pc, Data_addr;
tri	instrmem_rd, Data_rd; 
tri	[15:0]	Instr_dout, Data_dout;
tri	[15:0]	Data_din;

  // pragma attribute hdl_top partition_module_xrtl                                            
// pragma uvmf custom clock_generator begin
  bit clk;
  // Instantiate a clk driver 
  // tbx clkgen
  initial begin
    clk = 0;
    #25ns;
    forever begin
      clk = ~clk;
      #5ns;
    end
  end
// pragma uvmf custom clock_generator end

// pragma uvmf custom reset_generator begin
  bit rst;
  // Instantiate a rst driver
  // tbx clkgen
  initial begin
    rst = 1; 
    #50ns;
    rst =  0; 
  end
// pragma uvmf custom reset_generator end

  // pragma uvmf custom module_item_additional begin
  // pragma uvmf custom module_item_additional end

  // Instantiate the signal bundle, monitor bfm and driver bfm for each interface.
  // The signal bundle, _if, contains signals to be connected to the DUT.
  // The monitor, monitor_bfm, observes the bus, _if, and captures transactions.
  // The driver, driver_bfm, drives transactions onto the bus, _if.
LC3 dut(.clock(clk), .reset(rst), .pc, .instrmem_rd, .Instr_dout, .Data_addr, .complete_instr, .complete_data,  .Data_din, .Data_dout, .Data_rd);
  // Instantiate the signal bundle, monitor bfm and driver bfm for each interface.
  // The signal bundle, _if, contains signals to be connected to the DUT.
  // The monitor, monitor_bfm, observes the bus, _if, and captures transactions.
  // The driver, driver_bfm, drives transactions onto the bus, _if.
  fetch_in_if  fetch_env_fin_agent_bus(
     // pragma uvmf custom fetch_env_fin_agent_bus_connections begin
     .clock(dut.clock), .reset(dut.reset), .enable_updatePC(dut.enable_updatePC), 
		.enable_fetch(dut.enable_fetch), .taddr(dut.pcout), .br_taken(dut.br_taken)
     // pragma uvmf custom fetch_env_fin_agent_bus_connections end
     );
  fetch_out_if  fetch_env_fout_agent_bus(
     // pragma uvmf custom fetch_env_fout_agent_bus_connections begin
     .clock(dut.clock), .reset(dut.reset), .npc(dut.npc_out_fetch), .pc(dut.pc), 
     .instrmem_rd(dut.instrmem_rd), .enable_fetch(dut.enable_fetch)
     // pragma uvmf custom fetch_env_fout_agent_bus_connections end
     );
  decode_in_if  decode_env_decode_in_agent_bus(
     // pragma uvmf custom decode_env_decode_in_agent_bus_connections begin
     .clock(dut.clock), .reset(dut.reset), .enable_decode(dut.enable_decode), 
     .instr_dout(dut.Instr_dout), .npc_in(dut.npc_out_fetch), .psr()		
     // pragma uvmf custom decode_env_decode_in_agent_bus_connections end
     );
  decode_out_if  decode_env_decode_out_agent_bus(
     // pragma uvmf custom decode_env_decode_out_agent_bus_connections begin
     .clock(dut.clock), .reset(dut.reset), .IR(dut.IR), .out_enable_decode(dut.enable_decode), 
     .W_Control(dut.W_Control), .E_Control(dut.E_Control), .Mem_Control(dut.Mem_Control),
     .npc_out(dut.npc_out_dec)
     // pragma uvmf custom decode_env_decode_out_agent_bus_connections end
     );
  execute_in_if  execute_env_execute_in_agent_bus(
     // pragma uvmf custom execute_env_execute_in_agent_bus_connections begin
     .clock(dut.clock), .reset(dut.reset), .Mem_Control_in(dut.Mem_Control), .E_Control(dut.E_Control), 
     .W_Control_in(dut.W_Control), .enable_execute(dut.enable_execute), .npc_in(dut.npc_out_dec), .IR(dut.IR), 
     .VSR1(dut.VSR1), .VSR2(dut.VSR2), .bypass_mem_1(dut.bypass_mem_1), .bypass_mem_2(dut.bypass_mem_2),
     .bypass_alu_1(dut.bypass_alu_1), .bypass_alu_2(dut.bypass_alu_2), .Mem_Bypass_Val(dut.memout) 
     // pragma uvmf custom execute_env_execute_in_agent_bus_connections end
     );
  execute_out_if  execute_env_execute_out_agent_bus(
     // pragma uvmf custom execute_env_execute_out_agent_bus_connections begin
     .clock(dut.clock), .reset(dut.reset), .Mem_Control_out(dut.Mem_Control_out), .W_Control_out(dut.W_Control_out), .enable_execute(dut.enable_execute),
     .pcout(dut.pcout), .aluout(dut.aluout), .dr(dut.dr) , .sr1(dut.sr1), .sr2(dut.sr2), .IR_Exec(dut.IR_Exec),
     .NZP(dut.NZP), .M_Data(dut.M_Data)
     // pragma uvmf custom execute_env_execute_out_agent_bus_connections end
     );
  memaccess_in_if  memaccess_env_memaccess_in_agt_bus(
     // pragma uvmf custom memaccess_env_memaccess_in_agt_bus_connections begin
     .clock(dut.clock), .reset(dut.reset), .M_Data(dut.M_Data), .M_Addr(dut.pcout),
     .M_Control(dut.Mem_Control_out), .mem_state(dut.mem_state), .DMem_dout(dut.Data_dout)
     // pragma uvmf custom memaccess_env_memaccess_in_agt_bus_connections end
     );
  memaccess_out_if  memaccess_env_memaccess_out_agt_bus(
     // pragma uvmf custom memaccess_env_memaccess_out_agt_bus_connections begin
     .clock(dut.clock), .reset(dut.reset), .DMem_addr(dut.Data_addr), .DMem_din(dut.Data_din), 
     .memout(dut.memout), .DMem_rd(dut.Data_rd)
     // pragma uvmf custom memaccess_env_memaccess_out_agt_bus_connections end
     );
  writeback_in_if  writeback_env_wb_in_bus(
     // pragma uvmf custom writeback_env_wb_in_bus_connections begin
     .clock(dut.clock), .reset(dut.reset), .npc(dut.npc_out_dec), .W_control_in(dut.W_Control_out), .aluout(dut.aluout),
     .pcout(dut.pcout), .memout(dut.memout), .enable_writeback(dut.enable_writeback), .sr1(dut.sr1), .sr2(dut.sr2), .dr(dut.dr)
     // pragma uvmf custom writeback_env_wb_in_bus_connections end
     );
  writeback_out_if  writeback_env_wb_out_bus(
     // pragma uvmf custom writeback_env_wb_out_bus_connections begin
     .clock(dut.clock), .reset(dut.reset), .VSR1(dut.VSR1), .VSR2(dut.VSR2), .psr(dut.psr)
     // pragma uvmf custom writeback_env_wb_out_bus_connections end
     );
  control_in_if  control_env_control_in_agent_bus(
     // pragma uvmf custom control_env_control_in_agent_bus_connections begin
     .clock(dut.clock), .reset(dut.reset), .complete_data(dut.complete_data), .complete_instr(dut.complete_instr),
     .IR(dut.IR), .NZP(dut.NZP), .psr(dut.psr), .IR_Exec(dut.IR_Exec), .IMem_dout(dut.Instr_dout)
     // pragma uvmf custom control_env_control_in_agent_bus_connections end
     );
  control_out_if  control_env_control_out_agent_bus(
     // pragma uvmf custom control_env_control_out_agent_bus_connections begin
     .clock(dut.clock), .reset(dut.reset), .enable_updatePC(dut.enable_updatePC), 
     .enable_fetch(dut.enable_fetch), .enable_decode(dut.enable_decode), .enable_execute(dut.enable_execute),
     .enable_writeback(dut.enable_writeback), .br_taken(dut.br_taken), .bypass_alu_1(dut.bypass_alu_1),
     .bypass_alu_2(dut.bypass_alu_2), .bypass_mem_1(dut.bypass_mem_1), .bypass_mem_2(dut.bypass_mem_2), .mem_state(dut.mem_state)
     // pragma uvmf custom control_env_control_out_agent_bus_connections end
     );
  imem_if  imem_agent_bus(
     // pragma uvmf custom imem_agent_bus_connections begin
     .clock(dut.clock), .reset(dut.reset), .PC(dut.pc), .instrmem_rd(dut.instrmem_rd), 
     .instr_dout(dut.Instr_dout), .complete_instr(dut.complete_instr), .l_macc()
     // pragma uvmf custom imem_agent_bus_connections end
     );
  dmem_if  dmem_agent_bus(
     // pragma uvmf custom dmem_agent_bus_connections begin
     .clock(dut.clock), .reset(dut.reset), .Data_din(dut.Data_din), .Data_addr(dut.Data_addr),
     .Data_rd(dut.Data_rd), .Data_dout(dut.Data_dout), .complete_data(dut.complete_data)
     // pragma uvmf custom dmem_agent_bus_connections end
     );






//   fetch_in_if  fetch_env_fin_agent_bus(
//      // pragma uvmf custom fetch_env_fin_agent_bus_connections begin
//      .clock(clk), .reset(rst)
//      // pragma uvmf custom fetch_env_fin_agent_bus_connections end
//      );
//   fetch_out_if  fetch_env_fout_agent_bus(
//      // pragma uvmf custom fetch_env_fout_agent_bus_connections begin
//      .clock(clk), .reset(rst)
//      // pragma uvmf custom fetch_env_fout_agent_bus_connections end
//      );
//   decode_in_if  decode_env_decode_in_agent_bus(
//      // pragma uvmf custom decode_env_decode_in_agent_bus_connections begin
//      .clock(clk), .reset(rst)
//      // pragma uvmf custom decode_env_decode_in_agent_bus_connections end
//      );
//   decode_out_if  decode_env_decode_out_agent_bus(
//      // pragma uvmf custom decode_env_decode_out_agent_bus_connections begin
//      .clock(clk), .reset(rst)
//      // pragma uvmf custom decode_env_decode_out_agent_bus_connections end
//      );
//   execute_in_if  execute_env_execute_in_agent_bus(
//      // pragma uvmf custom execute_env_execute_in_agent_bus_connections begin
//      .clock(clk), .reset(rst)
//      // pragma uvmf custom execute_env_execute_in_agent_bus_connections end
//      );
//   execute_out_if  execute_env_execute_out_agent_bus(
//      // pragma uvmf custom execute_env_execute_out_agent_bus_connections begin
//      .clock(clk), .reset(rst)
//      // pragma uvmf custom execute_env_execute_out_agent_bus_connections end
//      );
//   memaccess_in_if  memaccess_env_memaccess_in_agt_bus(
//      // pragma uvmf custom memaccess_env_memaccess_in_agt_bus_connections begin
//      .clock(clk), .reset(rst)
//      // pragma uvmf custom memaccess_env_memaccess_in_agt_bus_connections end
//      );
//   memaccess_out_if  memaccess_env_memaccess_out_agt_bus(
//      // pragma uvmf custom memaccess_env_memaccess_out_agt_bus_connections begin
//      .clock(clk), .reset(rst)
//      // pragma uvmf custom memaccess_env_memaccess_out_agt_bus_connections end
//      );
//   writeback_in_if  writeback_env_wb_in_bus(
//      // pragma uvmf custom writeback_env_wb_in_bus_connections begin
//      .clock(clk), .reset(rst)
//      // pragma uvmf custom writeback_env_wb_in_bus_connections end
//      );
//   writeback_out_if  writeback_env_wb_out_bus(
//      // pragma uvmf custom writeback_env_wb_out_bus_connections begin
//      .clock(clk), .reset(rst)
//      // pragma uvmf custom writeback_env_wb_out_bus_connections end
//      );
//   control_in_if  control_env_control_in_agent_bus(
//      // pragma uvmf custom control_env_control_in_agent_bus_connections begin
//      .clock(clk), .reset(rst)
//      // pragma uvmf custom control_env_control_in_agent_bus_connections end
//      );
//   control_out_if  control_env_control_out_agent_bus(
//      // pragma uvmf custom control_env_control_out_agent_bus_connections begin
//      .clock(clk), .reset(rst)
//      // pragma uvmf custom control_env_control_out_agent_bus_connections end
//      );
//   imem_if  imem_agent_bus(
//      // pragma uvmf custom imem_agent_bus_connections begin
//      .clock(clk), .reset(rst)
//      // pragma uvmf custom imem_agent_bus_connections end
//      );
//   dmem_if  dmem_agent_bus(
//      // pragma uvmf custom dmem_agent_bus_connections begin
//      .clock(clk), .reset(rst)
//      // pragma uvmf custom dmem_agent_bus_connections end
//      );
  fetch_in_monitor_bfm  fetch_env_fin_agent_mon_bfm(fetch_env_fin_agent_bus);
  fetch_out_monitor_bfm  fetch_env_fout_agent_mon_bfm(fetch_env_fout_agent_bus);
  decode_in_monitor_bfm  decode_env_decode_in_agent_mon_bfm(decode_env_decode_in_agent_bus);
  decode_out_monitor_bfm  decode_env_decode_out_agent_mon_bfm(decode_env_decode_out_agent_bus);
  execute_in_monitor_bfm  execute_env_execute_in_agent_mon_bfm(execute_env_execute_in_agent_bus);
  execute_out_monitor_bfm  execute_env_execute_out_agent_mon_bfm(execute_env_execute_out_agent_bus);
  memaccess_in_monitor_bfm  memaccess_env_memaccess_in_agt_mon_bfm(memaccess_env_memaccess_in_agt_bus);
  memaccess_out_monitor_bfm  memaccess_env_memaccess_out_agt_mon_bfm(memaccess_env_memaccess_out_agt_bus);
  writeback_in_monitor_bfm  writeback_env_wb_in_mon_bfm(writeback_env_wb_in_bus);
  writeback_out_monitor_bfm  writeback_env_wb_out_mon_bfm(writeback_env_wb_out_bus);
  control_in_monitor_bfm  control_env_control_in_agent_mon_bfm(control_env_control_in_agent_bus);
  control_out_monitor_bfm  control_env_control_out_agent_mon_bfm(control_env_control_out_agent_bus);
  imem_monitor_bfm  imem_agent_mon_bfm(imem_agent_bus);
  dmem_monitor_bfm  dmem_agent_mon_bfm(dmem_agent_bus);
  imem_driver_bfm  imem_agent_drv_bfm(imem_agent_bus);
  dmem_driver_bfm  dmem_agent_drv_bfm(dmem_agent_bus);

  // pragma uvmf custom dut_instantiation begin
  // UVMF_CHANGE_ME : Add DUT and connect to signals in _bus interfaces listed above
  // Instantiate your DUT here
  // These DUT's instantiated to show verilog and vhdl instantiation
  verilog_dut         dut_verilog(   .clk(clk), .rst(rst), .in_signal(vhdl_to_verilog_signal), .out_signal(verilog_to_vhdl_signal));
  vhdl_dut            dut_vhdl   (   .clk(clk), .rst(rst), .in_signal(verilog_to_vhdl_signal), .out_signal(vhdl_to_verilog_signal));
  // pragma uvmf custom dut_instantiation end

  initial begin      // tbx vif_binding_block 
    import uvm_pkg::uvm_config_db;
    // The monitor_bfm and driver_bfm for each interface is placed into the uvm_config_db.
    // They are placed into the uvm_config_db using the string names defined in the parameters package.
    // The string names are passed to the agent configurations by test_top through the top level configuration.
    // They are retrieved by the agents configuration class for use by the agent.
    uvm_config_db #( virtual fetch_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , fetch_env_fin_agent_BFM , fetch_env_fin_agent_mon_bfm ); 
    uvm_config_db #( virtual fetch_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , fetch_env_fout_agent_BFM , fetch_env_fout_agent_mon_bfm ); 
    uvm_config_db #( virtual decode_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , decode_env_decode_in_agent_BFM , decode_env_decode_in_agent_mon_bfm ); 
    uvm_config_db #( virtual decode_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , decode_env_decode_out_agent_BFM , decode_env_decode_out_agent_mon_bfm ); 
    uvm_config_db #( virtual execute_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , execute_env_execute_in_agent_BFM , execute_env_execute_in_agent_mon_bfm ); 
    uvm_config_db #( virtual execute_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , execute_env_execute_out_agent_BFM , execute_env_execute_out_agent_mon_bfm ); 
    uvm_config_db #( virtual memaccess_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , memaccess_env_memaccess_in_agt_BFM , memaccess_env_memaccess_in_agt_mon_bfm ); 
    uvm_config_db #( virtual memaccess_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , memaccess_env_memaccess_out_agt_BFM , memaccess_env_memaccess_out_agt_mon_bfm ); 
    uvm_config_db #( virtual writeback_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , writeback_env_wb_in_BFM , writeback_env_wb_in_mon_bfm ); 
    uvm_config_db #( virtual writeback_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , writeback_env_wb_out_BFM , writeback_env_wb_out_mon_bfm ); 
    uvm_config_db #( virtual control_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , control_env_control_in_agent_BFM , control_env_control_in_agent_mon_bfm ); 
    uvm_config_db #( virtual control_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , control_env_control_out_agent_BFM , control_env_control_out_agent_mon_bfm ); 
    uvm_config_db #( virtual imem_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , imem_agent_BFM , imem_agent_mon_bfm ); 
    uvm_config_db #( virtual dmem_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , dmem_agent_BFM , dmem_agent_mon_bfm ); 
    uvm_config_db #( virtual imem_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , imem_agent_BFM , imem_agent_drv_bfm  );
    uvm_config_db #( virtual dmem_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , dmem_agent_BFM , dmem_agent_drv_bfm  );
  end

endmodule

// pragma uvmf custom external begin
// pragma uvmf custom external end

