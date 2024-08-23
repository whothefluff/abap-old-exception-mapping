"! <p class="shorttext synchronized" lang="EN">Supplier of no-check exc. with free message</p>
class zcl_nocheck_e_w_f_msg_supplier definition
                                     public
                                     create public.

  public section.

    interfaces: zif_exc_supplier.

    types t_free_message type string.

    methods constructor
              importing
                i_free_message type zcl_nocheck_e_w_f_msg_supplier=>t_free_message.

  protected section.

    data a_free_message type zcl_nocheck_e_w_f_msg_supplier=>t_free_message.

endclass.
class zcl_nocheck_e_w_f_msg_supplier implementation.

  method constructor.

    me->a_free_message = i_free_message.

  endmethod.
  method zif_exc_supplier~get.

    r_val = new zcx_no_check( new zcl_free_message( me->a_free_message ) ).

  endmethod.

endclass.
