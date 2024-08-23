"! <p class="shorttext synchronized" lang="EN">Supplier of no-check exc. with system message</p>
class zcl_nocheck_e_w_symsg_supplier definition
                                     public
                                     create public.

  public section.

    interfaces: zif_exc_supplier.

endclass.
class zcl_nocheck_e_w_symsg_supplier implementation.

  method zif_exc_supplier~get.

    r_val = new zcx_no_check( new zcl_sy_message( ) ).

  endmethod.

endclass.
