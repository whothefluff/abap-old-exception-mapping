class zcl_exc_supplier definition
                       public
                       create public.

  public section.

    interfaces: zif_exc_supplier.

    types t_exc type ref to cx_root.

    methods constructor
              importing
                i_exc type zcl_exc_supplier=>t_exc.

  protected section.

    data an_exc type zcl_exc_supplier=>t_exc.

endclass.
class zcl_exc_supplier implementation.

  method constructor.

    me->an_exc = i_exc.

  endmethod.
  method zif_exc_supplier~get.

    r_val = me->an_exc.

  endmethod.

endclass.
