# abap-old-exception-mapping

Convert old exceptions into class-based exceptions

## Use

You can use class _ZCL_NOCHECK_E_SUPPLIER_FOR_FM_ and inject it to an instance of _ZCL_OLD_EXC_MAPPER_ to convert FM exceptions (including RFC) into a ZCX_NO_CHECK exception:
```abap
data(rfc_fail_msg) = new zcl_nocheck_e_supplier_for_fm=>t_rfc_fail_msg( ).
 
data(exc_mapper) = new zcl_old_exc_mapper( new zcl_nocheck_e_supplier_for_fm( i_old_sy_msg = new zcl_sy_message( )
                                                                              i_rfc_fail_msg = rfc_fail_msg ) ).

call function i_rfc_name
  destination i_destination
  exporting
    im_insert_data        = i_entry
  importing
    ex_inserted_data      = e_entity
  exceptions
    communication_failure = 70 message rfc_fail_msg->*
    system_failure        = 80 message rfc_fail_msg->*
    insert_err            = 1
    others                = 90.

if sy-subrc ne 0.

  raise exception exc_mapper->to_class_based_exc( sy-subrc ).

endif.
```

With subclasses of the abap-messages repository you can even create new exceptions with the message of the mapped exception:
```abap
                   "inheriting from ZCX_STATIC_CHECK for example
raise exception new zcx_something( cast #( exc_mapper->to_class_based_exc( sy-subrc ) ) ).
```

There are also classes _ZCL_NOCHECK_E_W_F_MSG_SUPPLIER_ and _ZCL_NOCHECK_E_W_SYMSG_SUPPLIER_ for convenience if you need to create exception suppliers with free messages or system messages.


Or you could also create your own implementation of _ZIF_EXC_SUPPLIER_.
   
# dependencies:
  - [https://github.com/whothefluff/abap-messages](https://github.com/whothefluff/abap-messages)
  - [https://github.com/whothefluff/abap-exceptions](https://github.com/whothefluff/abap-exceptions)
