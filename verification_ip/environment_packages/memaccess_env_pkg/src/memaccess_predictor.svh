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
//   memaccess_analysis_predictor_export receives transactions of type  memaccess_in_transaction
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//  memaccess_analysis_predictor_port broadcasts transactions of type memaccess_out_transaction
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class memaccess_predictor #(
  type CONFIG_T,
  type BASE_T = uvm_component
  )
 extends BASE_T;

  // Factory registration of this class
  `uvm_component_param_utils( memaccess_predictor #(
                              CONFIG_T,
                              BASE_T
                              )
)


  // Instantiate a handle to the configuration of the environment in which this component resides
  CONFIG_T configuration;

  
  // Instantiate the analysis exports
  uvm_analysis_imp_memaccess_analysis_predictor_export #(memaccess_in_transaction, memaccess_predictor #(
                              .CONFIG_T(CONFIG_T),
                              .BASE_T(BASE_T)
                              )
) memaccess_analysis_predictor_export;

  
  // Instantiate the analysis ports
  uvm_analysis_port #(memaccess_out_transaction) memaccess_analysis_predictor_port;


  // Transaction variable for predicted values to be sent out memaccess_analysis_predictor_port
  // Once a transaction is sent through an analysis_port, another transaction should
  // be constructed for the next predicted transaction. 
  typedef memaccess_out_transaction memaccess_analysis_predictor_port_output_transaction_t;
  memaccess_analysis_predictor_port_output_transaction_t memaccess_analysis_predictor_port_output_transaction;
  // Code for sending output transaction out through memaccess_analysis_predictor_port
  // memaccess_analysis_predictor_port.write(memaccess_analysis_predictor_port_output_transaction);

  // Define transaction handles for debug visibility 
  memaccess_in_transaction memaccess_analysis_predictor_export_debug;


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

    memaccess_analysis_predictor_export = new("memaccess_analysis_predictor_export", this);
    memaccess_analysis_predictor_port =new("memaccess_analysis_predictor_port", this );
  // pragma uvmf custom build_phase begin
  // pragma uvmf custom build_phase end
  endfunction

  // FUNCTION: write_memaccess_analysis_predictor_export
  // Transactions received through memaccess_analysis_predictor_export initiate the execution of this function.
  // This function performs prediction of DUT output values based on DUT input, configuration and state
  virtual function void write_memaccess_analysis_predictor_export(memaccess_in_transaction t);
    // pragma uvmf custom memaccess_analysis_predictor_export_predictor begin
    memaccess_analysis_predictor_export_debug = t;
    `uvm_info("PRED", "Transaction Received through memaccess_analysis_predictor_export", UVM_MEDIUM)
    `uvm_info("PRED", {"            Data: ",t.convert2string()}, UVM_FULL)
    // Construct one of each output transaction type.
    memaccess_analysis_predictor_port_output_transaction = memaccess_analysis_predictor_port_output_transaction_t::type_id::create("memaccess_analysis_predictor_port_output_transaction");
    void'(mem_access_model(t.M_Data, t.M_Addr, t.M_Control, t.mem_state, t.DMem_dout,
                      memaccess_analysis_predictor_port_output_transaction.DMem_addr,
                      memaccess_analysis_predictor_port_output_transaction.DMem_din,
                      memaccess_analysis_predictor_port_output_transaction.memout,
                      memaccess_analysis_predictor_port_output_transaction.DMem_rd
    ));
    // Code for sending output transaction out through memaccess_analysis_predictor_port
    // Please note that each broadcasted transaction should be a different object than previously 
    // broadcasted transactions.  Creation of a different object is done by constructing the transaction 
    // using either new() or create().  Broadcasting a transaction object more than once to either the 
    // same subscriber or multiple subscribers will result in unexpected and incorrect behavior.
    memaccess_analysis_predictor_port.write(memaccess_analysis_predictor_port_output_transaction);
    // pragma uvmf custom memaccess_analysis_predictor_export_predictor end
  endfunction


endclass 

// pragma uvmf custom external begin
// pragma uvmf custom external end

