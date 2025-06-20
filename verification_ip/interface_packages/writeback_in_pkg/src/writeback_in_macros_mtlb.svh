//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This file contains macros used with the writeback_in package.
//   These macros include packed struct definitions.  These structs are
//   used to pass data between classes, hvl, and BFM's, hdl.  Use of 
//   structs are more efficient and simpler to modify.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_struct
//      and from_struct methods defined in the macros below that are used in  
//      the writeback_in_configuration class.
//
  `define writeback_in_CONFIGURATION_STRUCT \
typedef struct packed  { \
     uvmf_active_passive_t active_passive; \
     uvmf_initiator_responder_t initiator_responder; \
     } writeback_in_configuration_s;

  `define writeback_in_CONFIGURATION_TO_STRUCT_FUNCTION \
  virtual function writeback_in_configuration_s to_struct();\
    writeback_in_configuration_struct = \
       {\
       this.active_passive,\
       this.initiator_responder\
       };\
    return ( writeback_in_configuration_struct );\
  endfunction

  `define writeback_in_CONFIGURATION_FROM_STRUCT_FUNCTION \
  virtual function void from_struct(writeback_in_configuration_s writeback_in_configuration_struct);\
      {\
      this.active_passive,\
      this.initiator_responder  \
      } = writeback_in_configuration_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_monitor_struct
//      and from_monitor_struct methods of the writeback_in_transaction class.
//
  `define writeback_in_MONITOR_STRUCT typedef struct packed  { \
  npc_t _npc ; \
  bit [1:0] _W_control_in ; \
  aluout_t _aluout ; \
  pcout_t _pcout ; \
  memout_t _memout ; \
  bit _enable_writeback ; \
  reg_t _sr1 ; \
  reg_t _sr2 ; \
  reg_t _dr ; \
     } writeback_in_monitor_s;

  `define writeback_in_TO_MONITOR_STRUCT_FUNCTION \
  virtual function writeback_in_monitor_s to_monitor_struct();\
    writeback_in_monitor_struct = \
            { \
            this._npc , \
            this._W_control_in , \
            this._aluout , \
            this._pcout , \
            this._memout , \
            this._enable_writeback , \
            this._sr1 , \
            this._sr2 , \
            this._dr  \
            };\
    return ( writeback_in_monitor_struct);\
  endfunction\

  `define writeback_in_FROM_MONITOR_STRUCT_FUNCTION \
  virtual function void from_monitor_struct(writeback_in_monitor_s writeback_in_monitor_struct);\
            {\
            this._npc , \
            this._W_control_in , \
            this._aluout , \
            this._pcout , \
            this._memout , \
            this._enable_writeback , \
            this._sr1 , \
            this._sr2 , \
            this._dr  \
            } = writeback_in_monitor_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_initiator_struct
//      and from_initiator_struct methods of the writeback_in_transaction class.
//      Also update the comments in the driver BFM.
//
  `define writeback_in_INITIATOR_STRUCT typedef struct packed  { \
  npc_t _npc ; \
  bit [1:0] _W_control_in ; \
  aluout_t _aluout ; \
  pcout_t _pcout ; \
  memout_t _memout ; \
  bit _enable_writeback ; \
  reg_t _sr1 ; \
  reg_t _sr2 ; \
  reg_t _dr ; \
     } writeback_in_initiator_s;

  `define writeback_in_TO_INITIATOR_STRUCT_FUNCTION \
  virtual function writeback_in_initiator_s to_initiator_struct();\
    writeback_in_initiator_struct = \
           {\
           this._npc , \
           this._W_control_in , \
           this._aluout , \
           this._pcout , \
           this._memout , \
           this._enable_writeback , \
           this._sr1 , \
           this._sr2 , \
           this._dr  \
           };\
    return ( writeback_in_initiator_struct);\
  endfunction

  `define writeback_in_FROM_INITIATOR_STRUCT_FUNCTION \
  virtual function void from_initiator_struct(writeback_in_initiator_s writeback_in_initiator_struct);\
           {\
           this._npc , \
           this._W_control_in , \
           this._aluout , \
           this._pcout , \
           this._memout , \
           this._enable_writeback , \
           this._sr1 , \
           this._sr2 , \
           this._dr  \
           } = writeback_in_initiator_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_responder_struct
//      and from_responder_struct methods of the writeback_in_transaction class.
//      Also update the comments in the driver BFM.
//
  `define writeback_in_RESPONDER_STRUCT typedef struct packed  { \
  npc_t _npc ; \
  bit [1:0] _W_control_in ; \
  aluout_t _aluout ; \
  pcout_t _pcout ; \
  memout_t _memout ; \
  bit _enable_writeback ; \
  reg_t _sr1 ; \
  reg_t _sr2 ; \
  reg_t _dr ; \
     } writeback_in_responder_s;

  `define writeback_in_TO_RESPONDER_STRUCT_FUNCTION \
  virtual function writeback_in_responder_s to_responder_struct();\
    writeback_in_responder_struct = \
           {\
           this._npc , \
           this._W_control_in , \
           this._aluout , \
           this._pcout , \
           this._memout , \
           this._enable_writeback , \
           this._sr1 , \
           this._sr2 , \
           this._dr  \
           };\
    return ( writeback_in_responder_struct);\
  endfunction

  `define writeback_in_FROM_RESPONDER_STRUCT_FUNCTION \
  virtual function void from_responder_struct(writeback_in_responder_s writeback_in_responder_struct);\
           {\
           this._npc , \
           this._W_control_in , \
           this._aluout , \
           this._pcout , \
           this._memout , \
           this._enable_writeback , \
           this._sr1 , \
           this._sr2 , \
           this._dr  \
           } = writeback_in_responder_struct;\
  endfunction
// pragma uvmf custom additional begin
// pragma uvmf custom additional end
