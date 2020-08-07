with Interfaces;

package System.GCC_Builtins is
   pragma Pure;

   subtype U8 is Interfaces.Unsigned_8;
   subtype I8 is Interfaces.Integer_8;
   subtype U16 is Interfaces.Unsigned_16;
   subtype I16 is Interfaces.Integer_16;
   subtype U32 is Interfaces.Unsigned_32;
   subtype U64 is Interfaces.Unsigned_64;

   --  MSP430 builtins, named in gcc-4.7.2/gcc/config/msp430/msp430-builtins.c
   procedure nop;
   procedure dint;
   procedure eint;
   --  status register
   function  read_status_register return U16;
   procedure write_status_register (status : U16);
   procedure bic_status_register (status : U16);
   procedure bis_status_register (status : U16);
   procedure bic_status_register_on_exit (status : U16);
   procedure bis_status_register_on_exit (status : U16);
   --  stack pointer
   function  read_stack_pointer return access U16;   --  System.Address;
   procedure write_stack_pointer (sp : access U16);
   --  others
   procedure delay_cycles (Ticks : U32);
   function  get_interrupt_state return U16;
   procedure set_interrupt_state (state : U16);
   function  swap_bytes (Bytes : U16) return U16;
   function  get_watchdog_clear_value return U16;
   procedure set_watchdog_clear_value (state : U16);
   procedure watchdog_clear;
   function even_in_range (A, B : U16) return U16;

private

   pragma Inline_Always (nop);
   pragma Inline_Always (dint);
   pragma Inline_Always (eint);
   pragma Inline_Always (read_status_register);
   pragma Inline_Always (write_status_register);
   pragma Inline_Always (bic_status_register);
   pragma Inline_Always (bis_status_register);
   pragma Inline_Always (bic_status_register_on_exit);
   pragma Inline_Always (bis_status_register_on_exit);
   pragma Inline_Always (read_stack_pointer);
   pragma Inline_Always (write_stack_pointer);
--  pragma Inline_Always (delay_cycles);
--  don't inline delay_cycles; this can generate a lot of code.
   pragma Inline_Always (get_interrupt_state);
   pragma Inline_Always (set_interrupt_state);
   pragma Inline_Always (swap_bytes);
   pragma Inline_Always (get_watchdog_clear_value);
   pragma Inline_Always (set_watchdog_clear_value);
   pragma Inline_Always (watchdog_clear);
   pragma Inline_Always (even_in_range);

   pragma Import (Intrinsic, nop, "__nop");
   pragma Import (Intrinsic, dint, "__dint");
   pragma Import (Intrinsic, eint, "__eint");
   pragma Import (Intrinsic, read_status_register, "__read_status_register");
   pragma Import (Intrinsic, write_status_register, "__write_status_register");
   pragma Import (Intrinsic, bic_status_register, "__bic_status_register");
   pragma Import (Intrinsic, bis_status_register, "__bis_status_register");
   pragma Import (Intrinsic, bic_status_register_on_exit,
                             "__bic_status_register_on_exit");
   pragma Import (Intrinsic, bis_status_register_on_exit,
                             "__bis_status_register_on_exit");
   pragma Import (Intrinsic, read_stack_pointer, "__read_stack_pointer");
   pragma Import (Intrinsic, write_stack_pointer, "__write_stack_pointer");
   pragma Import (Intrinsic, delay_cycles, "__delay_cycles");
   pragma Import (Intrinsic, get_interrupt_state, "__get_interrupt_state");
   pragma Import (Intrinsic, set_interrupt_state, "__set_interrupt_state");
   pragma Import (Intrinsic, swap_bytes, "__swap_bytes");
   pragma Import (Intrinsic, get_watchdog_clear_value,
                             "__get_watchdog_clear_value");
   pragma Import (Intrinsic, set_watchdog_clear_value,
                             "__set_watchdog_clear_value");
   pragma Import (Intrinsic, watchdog_clear, "__watchdog_clear");
   pragma Import (Intrinsic, even_in_range, "__even_in_range");

end System.GCC_Builtins;
