//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class can be used to provide stimulus when an interface
//              has been configured to run in a responder mode. It
//              will never finish by default, always going back to the driver
//              and driver BFM for the next transaction with which to respond.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class imem_initialize_sequence 
  extends imem_sequence_base;

  `uvm_object_utils( imem_initialize_sequence )
  imem_transaction temp;
  bit [15:0] new_PC;
  bit [15:0] old_PC;
  bit instrmem_rd;
  bit [3:0] count;
  bit first_instr;
  bit last_load_done;
  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_initialize_sequence");
    super.new(name);
    first_instr=1;
    old_PC = 'd0;
    new_PC = 'd0;
    instrmem_rd = 'b0;
    count = 0;
    last_load_done = 0;
    temp=imem_transaction::type_id::create("temp");
  endfunction

  task body();
    req=imem_transaction::type_id::create("req");
    while(!last_load_done) begin
      start_item(req);
      if(count == 8) begin
          last_load_done = 1;
      end
      //if(!req.randomize()) `uvm_fatal("SEQ", "imem_random_sequence::body()-imem_transaction randomization failed")
      if(instrmem_rd & ((new_PC == 16'h3000) | (new_PC > old_PC))) begin
        temp.instr_dout[15:12] = 4'b0010;
        temp.instr_dout[11:9] = count[2:0];
        temp.instr_dout[8:0] = 9'd0;
        old_PC = new_PC;
        if(!first_instr) begin
          count = count + 'd1;
        end
        first_instr = 0;
      end
      temp.complete_instr = 'b1;

      req.do_copy(temp);
      finish_item(req);
      get_response(req);
      new_PC = req.NPC;
      instrmem_rd = req.instrmem_rd;
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the responder sequence.
      // If this was an item that required a response, the expectation is
      // that the response should be populated within this transaction now.
      `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_MEDIUM)
      // pragma uvmf custom body end
    end
  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

