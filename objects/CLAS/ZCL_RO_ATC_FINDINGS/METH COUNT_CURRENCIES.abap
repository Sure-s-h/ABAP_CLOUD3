  METHOD count_currencies.
    SELECT FROM i_currency
      FIELDS currency
      WHERE currency IS NOT INITIAL
      INTO TABLE @DATA(lt_currency).

    rv_count = lines( lt_currency ).

    IF iv_divisor > 1.
      rv_count = rv_count DIV iv_divisor.
    ENDIF.
  ENDMETHOD.