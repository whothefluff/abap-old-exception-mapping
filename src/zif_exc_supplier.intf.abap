"! <p class="shorttext synchronized" lang="EN">Exception supplier</p>
interface zif_exc_supplier public.

  "! <p class="shorttext synchronized" lang="EN">Gets the exception</p>
  "!
  "! @parameter r_val | <p class="shorttext synchronized" lang="EN">A class-based exception</p>
  methods get
            returning
              value(r_val) type ref to cx_root.

endinterface.
