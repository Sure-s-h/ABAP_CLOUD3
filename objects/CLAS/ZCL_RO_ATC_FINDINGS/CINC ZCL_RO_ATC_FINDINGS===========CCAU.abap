CLASS ltc_atc_findings DEFINITION FINAL
  FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA cut      TYPE REF TO zcl_ro_atc_findings.
    DATA db_count TYPE i.

    METHODS setup.
    METHODS currency_count_not_zero     FOR TESTING.
    METHODS divisor_zero_no_dump        FOR TESTING.
    METHODS divisor_one_equals_db_count FOR TESTING.
    METHODS divisor_two_halves_count    FOR TESTING.
    METHODS negative_divisor_full_count FOR TESTING.
    METHODS large_divisor_returns_zero  FOR TESTING.
    METHODS result_never_negative       FOR TESTING.
ENDCLASS.


CLASS ltc_atc_findings IMPLEMENTATION.

  METHOD setup.
    cut = NEW #( ).

    " Reference value read directly from the database test
    SELECT COUNT(*) FROM i_currency
      WHERE currency IS NOT INITIAL
      INTO @db_count.
  ENDMETHOD.

  METHOD currency_count_not_zero.
    cl_abap_unit_assert=>assert_differs(
      act = cut->count_currencies( 1 )
      exp = 0
      msg = 'Currency count should not be zero' ).
  ENDMETHOD.

  METHOD divisor_zero_no_dump.
    " Divisor 0 must not cause a short dump -> full count returned
    cl_abap_unit_assert=>assert_equals(
      act = cut->count_currencies( 0 )
      exp = db_count ).
  ENDMETHOD.

  METHOD divisor_one_equals_db_count.
    cl_abap_unit_assert=>assert_equals(
      act = cut->count_currencies( 1 )
      exp = db_count ).
  ENDMETHOD.

  METHOD divisor_two_halves_count.
    cl_abap_unit_assert=>assert_equals(
      act = cut->count_currencies( 2 )
      exp = db_count DIV 2 ).
  ENDMETHOD.

  METHOD negative_divisor_full_count.
    " Negative divisor is ignored -> full count
    cl_abap_unit_assert=>assert_equals(
      act = cut->count_currencies( -5 )
      exp = db_count ).
  ENDMETHOD.

  METHOD large_divisor_returns_zero.
    " Far fewer than 1,000,000 currencies exist -> 0
    cl_abap_unit_assert=>assert_equals(
      act = cut->count_currencies( 1000000 )
      exp = 0 ).
  ENDMETHOD.

  METHOD result_never_negative.
    cl_abap_unit_assert=>assert_true(
      act = xsdbool( cut->count_currencies( 3 ) >= 0 )
      msg = 'Count must never be negative' ).
  ENDMETHOD.

ENDCLASS.
