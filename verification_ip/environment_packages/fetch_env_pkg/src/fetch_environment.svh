//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This environment contains all agents, predictors and
// scoreboards required for the block level design.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class fetch_environment  extends uvmf_environment_base #(
    .CONFIG_T( fetch_env_configuration 
  ));
  `uvm_component_utils( fetch_environment )





  typedef fetch_in_agent  fin_agent_t;
  fin_agent_t fin_agent;

  typedef fetch_out_agent  fout_agent_t;
  fout_agent_t fout_agent;




  typedef fetch_predictor #(
                .CONFIG_T(CONFIG_T)
                )
 fetch_pred_t;
  fetch_pred_t fetch_pred;

  typedef uvmf_in_order_scoreboard #(.T(fetch_out_transaction))  fetch_scoreboard_t;
  fetch_scoreboard_t fetch_scoreboard;



  typedef uvmf_virtual_sequencer_base #(.CONFIG_T(fetch_env_configuration)) fetch_vsqr_t;
  fetch_vsqr_t vsqr;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
 
// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

// ****************************************************************************
// FUNCTION: build_phase()
// This function builds all components within this environment.
//
  virtual function void build_phase(uvm_phase phase);
// pragma uvmf custom build_phase_pre_super begin
// pragma uvmf custom build_phase_pre_super end
    super.build_phase(phase);
    fin_agent = fin_agent_t::type_id::create("fin_agent",this);
    fin_agent.set_config(configuration.fin_agent_config);
    fout_agent = fout_agent_t::type_id::create("fout_agent",this);
    fout_agent.set_config(configuration.fout_agent_config);
    fetch_pred = fetch_pred_t::type_id::create("fetch_pred",this);
    fetch_pred.configuration = configuration;
    fetch_scoreboard = fetch_scoreboard_t::type_id::create("fetch_scoreboard",this);
    
    vsqr = fetch_vsqr_t::type_id::create("vsqr", this);
    vsqr.set_config(configuration);
    configuration.set_vsqr(vsqr);

    // pragma uvmf custom build_phase begin
    // pragma uvmf custom build_phase end
  endfunction

// ****************************************************************************
// FUNCTION: connect_phase()
// This function makes all connections within this environment.  Connections
// typically inclue agent to predictor, predictor to scoreboard and scoreboard
// to agent.
//
  virtual function void connect_phase(uvm_phase phase);
// pragma uvmf custom connect_phase_pre_super begin
fetch_scoreboard.disable_end_of_test_empty_check();
// pragma uvmf custom connect_phase_pre_super end
    super.connect_phase(phase);
    fin_agent.monitored_ap.connect(fetch_pred.agent_analysis_export);
    fetch_pred.predictor_analysis_port.connect(fetch_scoreboard.expected_analysis_export);
    fout_agent.monitored_ap.connect(fetch_scoreboard.actual_analysis_export);
    // pragma uvmf custom reg_model_connect_phase begin
    // pragma uvmf custom reg_model_connect_phase end
  endfunction

// ****************************************************************************
// FUNCTION: end_of_simulation_phase()
// This function is executed just prior to executing run_phase.  This function
// was added to the environment to sample environment configuration settings
// just before the simulation exits time 0.  The configuration structure is 
// randomized in the build phase before the environment structure is constructed.
// Configuration variables can be customized after randomization in the build_phase
// of the extended test.
// If a sequence modifies values in the configuration structure then the sequence is
// responsible for sampling the covergroup in the configuration if required.
//
  virtual function void start_of_simulation_phase(uvm_phase phase);
     configuration.fetch_configuration_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

