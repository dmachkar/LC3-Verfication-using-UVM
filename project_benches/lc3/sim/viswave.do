 

onerror resume
wave tags F0
wave update off

wave spacer -backgroundcolor Salmon { fetch_env_fin_agent }
wave add uvm_test_top.environment.fetch_env.fin_agent.fin_agent_monitor.txn_stream -radix string -tag F0
wave group fetch_env_fin_agent_bus
wave add -group fetch_env_fin_agent_bus hdl_top.fetch_env_fin_agent_bus.* -radix hexadecimal -tag F0
wave group fetch_env_fin_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { fetch_env_fout_agent }
wave add uvm_test_top.environment.fetch_env.fout_agent.fout_agent_monitor.txn_stream -radix string -tag F0
wave group fetch_env_fout_agent_bus
wave add -group fetch_env_fout_agent_bus hdl_top.fetch_env_fout_agent_bus.* -radix hexadecimal -tag F0
wave group fetch_env_fout_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { decode_env_decode_in_agent }
wave add uvm_test_top.environment.decode_env.decode_in_agent.decode_in_agent_monitor.txn_stream -radix string -tag F0
wave group decode_env_decode_in_agent_bus
wave add -group decode_env_decode_in_agent_bus hdl_top.decode_env_decode_in_agent_bus.* -radix hexadecimal -tag F0
wave group decode_env_decode_in_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { decode_env_decode_out_agent }
wave add uvm_test_top.environment.decode_env.decode_out_agent.decode_out_agent_monitor.txn_stream -radix string -tag F0
wave group decode_env_decode_out_agent_bus
wave add -group decode_env_decode_out_agent_bus hdl_top.decode_env_decode_out_agent_bus.* -radix hexadecimal -tag F0
wave group decode_env_decode_out_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { execute_env_execute_in_agent }
wave add uvm_test_top.environment.execute_env.execute_in_agent.execute_in_agent_monitor.txn_stream -radix string -tag F0
wave group execute_env_execute_in_agent_bus
wave add -group execute_env_execute_in_agent_bus hdl_top.execute_env_execute_in_agent_bus.* -radix hexadecimal -tag F0
wave group execute_env_execute_in_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { execute_env_execute_out_agent }
wave add uvm_test_top.environment.execute_env.execute_out_agent.execute_out_agent_monitor.txn_stream -radix string -tag F0
wave group execute_env_execute_out_agent_bus
wave add -group execute_env_execute_out_agent_bus hdl_top.execute_env_execute_out_agent_bus.* -radix hexadecimal -tag F0
wave group execute_env_execute_out_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { memaccess_env_memaccess_in_agt }
wave add uvm_test_top.environment.memaccess_env.memaccess_in_agt.memaccess_in_agt_monitor.txn_stream -radix string -tag F0
wave group memaccess_env_memaccess_in_agt_bus
wave add -group memaccess_env_memaccess_in_agt_bus hdl_top.memaccess_env_memaccess_in_agt_bus.* -radix hexadecimal -tag F0
wave group memaccess_env_memaccess_in_agt_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { memaccess_env_memaccess_out_agt }
wave add uvm_test_top.environment.memaccess_env.memaccess_out_agt.memaccess_out_agt_monitor.txn_stream -radix string -tag F0
wave group memaccess_env_memaccess_out_agt_bus
wave add -group memaccess_env_memaccess_out_agt_bus hdl_top.memaccess_env_memaccess_out_agt_bus.* -radix hexadecimal -tag F0
wave group memaccess_env_memaccess_out_agt_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { writeback_env_wb_in }
wave add uvm_test_top.environment.writeback_env.wb_in.wb_in_monitor.txn_stream -radix string -tag F0
wave group writeback_env_wb_in_bus
wave add -group writeback_env_wb_in_bus hdl_top.writeback_env_wb_in_bus.* -radix hexadecimal -tag F0
wave group writeback_env_wb_in_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { writeback_env_wb_out }
wave add uvm_test_top.environment.writeback_env.wb_out.wb_out_monitor.txn_stream -radix string -tag F0
wave group writeback_env_wb_out_bus
wave add -group writeback_env_wb_out_bus hdl_top.writeback_env_wb_out_bus.* -radix hexadecimal -tag F0
wave group writeback_env_wb_out_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { control_env_control_in_agent }
wave add uvm_test_top.environment.control_env.control_in_agent.control_in_agent_monitor.txn_stream -radix string -tag F0
wave group control_env_control_in_agent_bus
wave add -group control_env_control_in_agent_bus hdl_top.control_env_control_in_agent_bus.* -radix hexadecimal -tag F0
wave group control_env_control_in_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { control_env_control_out_agent }
wave add uvm_test_top.environment.control_env.control_out_agent.control_out_agent_monitor.txn_stream -radix string -tag F0
wave group control_env_control_out_agent_bus
wave add -group control_env_control_out_agent_bus hdl_top.control_env_control_out_agent_bus.* -radix hexadecimal -tag F0
wave group control_env_control_out_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { imem_agent }
wave add uvm_test_top.environment.imem_agent.imem_agent_monitor.txn_stream -radix string -tag F0
wave group imem_agent_bus
wave add -group imem_agent_bus hdl_top.imem_agent_bus.* -radix hexadecimal -tag F0
wave group imem_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { dmem_agent }
wave add uvm_test_top.environment.dmem_agent.dmem_agent_monitor.txn_stream -radix string -tag F0
wave group dmem_agent_bus
wave add -group dmem_agent_bus hdl_top.dmem_agent_bus.* -radix hexadecimal -tag F0
wave group dmem_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]



wave update on
WaveSetStreamView

