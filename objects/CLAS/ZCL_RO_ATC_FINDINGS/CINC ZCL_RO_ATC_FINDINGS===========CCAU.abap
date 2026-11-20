CLASS ltc_atc_findings DEFINITION FINAL
  FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA cut TYPE REF TO zcl_ro_atc_findings.

    METHODS setup.
    METHODS currency_count_not_zero FOR TESTING.
    METHODS divisor_zero_no_dump    FOR TESTING.
ENDCLASS.


CLASS ltc_atc_findings IMPLEMENTATION.

  METHOD setup.
    cut = NEW #( ).
  ENDMETHOD.

  METHOD currency_count_not_zero.
    cl_abap_unit_assert=>assert_differs(
      act = cut->count_currencies( 1 )
      exp = 0
      msg = 'Currency count should not be zero' ).
  ENDMETHOD.

  METHOD divisor_zero_no_dump.
    cl_abap_unit_assert=>assert_differs(
      act = cut->count_currencies( 0 )
      exp = 0
      msg = 'Divisor 0 must not cause a short dump' ).
  ENDMETHOD.

ENDCLASS.