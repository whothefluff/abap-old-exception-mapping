"! <p class="shorttext synchronized" lang="EN">Old exceptions mapper</p>
class zcl_old_exc_mapper definition
                         public
                         create public.

  public section.

    types t_supplier type ref to zif_exc_supplier.

    types: begin of t_mapping,
             rc type sy-subrc,
             supplier type zcl_old_exc_mapper=>t_supplier,
           end of t_mapping,
           t_mappings type sorted table of zcl_old_exc_mapper=>t_mapping with unique key rc.

  "! <p class="shorttext synchronized" lang="EN"></p>
  "!
  "! @parameter i_mappings | <p class="shorttext synchronized" lang="EN"></p>
  "! @parameter i_default | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_mappings type zcl_old_exc_mapper=>t_mappings optional
                i_default type zcl_old_exc_mapper=>t_supplier optional
                preferred parameter i_default.

  "! <p class="shorttext synchronized" lang="EN">Gets the new exception</p>
  "!
  "! @parameter i_return_code | <p class="shorttext synchronized" lang="EN">sy-subrc</p>
  "! @parameter r_val | <p class="shorttext synchronized" lang="EN">A class-based exception</p>
    methods to_class_based_exc
              importing
                i_return_code type sy-subrc
              returning
                value(r_val) type ref to cx_root.

  protected section.

    data a_mapping_list type zcl_old_exc_mapper=>t_mappings.

    data a_default_supplier type zcl_old_exc_mapper=>t_supplier.

endclass.
class zcl_old_exc_mapper implementation.

  method constructor.

    me->a_default_supplier = i_default.

    me->a_mapping_list = i_mappings.

  endmethod.
  method to_class_based_exc.

    r_val = cast #( let supplier = value #( me->a_mapping_list[ rc = i_return_code ]-supplier default me->a_default_supplier ) in
                    supplier->get( ) ).

  endmethod.

endclass.
