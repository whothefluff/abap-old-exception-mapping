"! <p class="shorttext synchronized" lang="EN">Generic supplier of no-check exc. for Function Modules</p>
class zcl_nocheck_e_supplier_for_fm definition
                                    public
                                    create public.

  public section.

    interfaces: zif_exc_supplier.

    types t_rfc_fail_msg type char255.

    types t_old_sy_msg type ref to if_message.

    "! <p class="shorttext synchronized" lang="EN">Creates a supplier that may look for RFC fail or error msgs.</p>
    "! The RFC failure message takes precedence over the potential error message
    "!
    "! @parameter i_rfc_fail_msg | <p class="shorttext synchronized" lang="EN">Supply when an error message may be issued</p>
    "! @parameter i_old_sy_msg | <p class="shorttext synchronized" lang="EN">Supply when an RFC failure message may be assigned</p>
    methods constructor
              importing
                i_rfc_fail_msg type ref to zcl_nocheck_e_supplier_for_fm=>t_rfc_fail_msg optional
                i_old_sy_msg type zcl_nocheck_e_supplier_for_fm=>t_old_sy_msg optional
                i_default_message type string default 'Function module error' ##NO_TEXT.

  protected section.

    methods msg_was_updated
              returning
                value(r_val) type xsdboolean.

    methods new_msg_is_error
              returning
                value(r_val) type xsdboolean.

    data an_rfc_fail_msg type ref to zcl_nocheck_e_supplier_for_fm=>t_rfc_fail_msg.

    data an_old_sy_msg type zcl_nocheck_e_supplier_for_fm=>t_old_sy_msg.

    data a_default_message type string.

    data a_current_sy_msg type ref to zcl_sy_message.

endclass.
class zcl_nocheck_e_supplier_for_fm implementation.

  method zif_exc_supplier~get.

    me->a_current_sy_msg = new zcl_sy_message( ).

    r_val = new zcx_no_check( cond #( when me->an_rfc_fail_msg is bound
                                           and me->an_rfc_fail_msg->* is not initial
                                      then new zcl_free_message( conv #( me->an_rfc_fail_msg->* ) )
                                      when me->an_old_sy_msg is bound
                                      then cond #( when me->msg_was_updated( )
                                                        and me->new_msg_is_error( )
                                                   then me->a_current_sy_msg
                                                   else new zcl_free_message( a_default_message ) )
                                      else new zcl_free_message( a_default_message ) ) ).

  endmethod.
  method constructor.

    me->an_rfc_fail_msg = i_rfc_fail_msg.

    me->an_old_sy_msg = i_old_sy_msg.

    me->a_default_message = i_default_message.

  endmethod.
  method msg_was_updated.

    r_val = xsdbool( me->an_old_sy_msg->get_text( ) ne me->a_current_sy_msg->get_text( ) ).

  endmethod.
  method new_msg_is_error.

    r_val = xsdbool( me->a_current_sy_msg->type CA 'XAE' ).

  endmethod.

endclass.
