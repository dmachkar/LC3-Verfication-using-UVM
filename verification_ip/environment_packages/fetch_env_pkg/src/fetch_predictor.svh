//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
//
// DESCRIPTION: This analysis component contains analysis_exports for receiving
//   data and analysis_ports for sending data.
// 
//   This analysis component has the following analysis_exports that receive the 
//   listed transaction type.
//   
//   agent_analysis_export receives transactions of type  fetch_in_transaction
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//  predictor_analysis_port broadcasts transactions of type fetch_out_transaction
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class fetch_predictor #(
  type CONFIG_T,
  type BASE_T = uvm_component
  )
 extends BASE_T;

  // Factory registration of this class
  `uvm_component_param_utils( fetch_predictor #(
                              CONFIG_T,
                              BASE_T
                              )
)


  // Instantiate a handle to the configuration of the environment in which this component resides
  CONFIG_T configuration;

  
  // Instantiate the analysis exports
  uvm_analysis_imp_agent_analysis_export #(fetch_in_transaction, fetch_predictor #(
                              .CONFIG_T(CONFIG_T),
                              .BASE_T(BASE_T)
                              )
) agent_analysis_export;

  
  // Instantiate the analysis ports
  uvm_analysis_port #(fetch_out_transaction) predictor_analysis_port;


  // Transaction variable for predicted values to be sent out predictor_analysis_port
  // Once a transaction is sent through an analysis_port, another transaction should
  // be constructed for the next predicted transaction. 
  typedef fetch_out_transaction predictor_analysis_port_output_transaction_t;
  predictor_analysis_port_output_transaction_t predictor_analysis_port_output_transaction;
  // Code for sending output transaction out through predictor_analysis_port
  // predictor_analysis_port.write(predictor_analysis_port_output_transaction);

  // Define transaction handles for debug visibility 
  fetch_in_transaction agent_analysis_export_debug;


  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  // FUNCTION: new
  function new(string name, uvm_component parent);
     super.new(name,parent);
    // `uvm_warning("PREDICTOR_REVIEW", "This predictor has been created either through generation or re-generation with merging.  Remove this warning after the predictor has been reviewed.")
  // pragma uvmf custom new begin
  // pragma uvmf custom new end
  endfunction

  // FUNCTION: build_phase
  virtual function void build_phase (uvm_phase phase);

    agent_analysis_export = new("agent_analysis_export", this);
    predictor_analysis_port =new("predictor_analysis_port", this );
  // pragma uvmf custom build_phase begin
  // pragma uvmf custom build_phase end
  endfunction

  // FUNCTION: write_agent_analysis_export
  // Transactions received through agent_analysis_export initiate the execution of this function.
  // This function performs prediction of DUT output values based on DUT input, configuration and state
  virtual function void write_agent_analysis_export(fetch_in_transaction t);
    // pragma uvmf custom agent_analysis_export_predictor begin
    agent_analysis_export_debug = t;
    `uvm_info("PRED", "Transaction Received through agent_analysis_export", UVM_MEDIUM)
    `uvm_info("PRED", {"            Data: ",t.convert2string()}, UVM_FULL)
    // Construct one of each output transaction type.
    predictor_analysis_port_output_transaction = predictor_analysis_port_output_transaction_t::type_id::create("predictor_analysis_port_output_transaction");
   void'(fetch_model(t.enable_updatePC, t.enable_fetch, t.br_taken, t.taddr,
              predictor_analysis_port_output_transaction.npc,
              predictor_analysis_port_output_transaction.pc,
              predictor_analysis_port_output_transaction.instrmem_rd
   ));
    // Code for sending output transaction out through predictor_analysis_port
    // Please note that each broadcasted transaction should be a different object than previously 
    // broadcasted transactions.  Creation of a different object is done by constructing the transaction 
    // using either new() or create().  Broadcasting a transaction object more than once to either the 
    // same subscriber or multiple subscribers will result in unexpected and incorrect behavior.
    predictor_analysis_port.write(predictor_analysis_port_output_transaction);
    // pragma uvmf custom agent_analysis_export_predictor end
  endfunction


endclass 

// pragma uvmf custom external begin
// pragma uvmf custom external end

