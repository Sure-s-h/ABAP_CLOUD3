CLASS zcl_ro_atc_findings DEFINITION
  PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    "! Returns the number of currencies maintained in the system
    METHODS count_currencies
      IMPORTING iv_divisor      TYPE i
      RETURNING VALUE(rv_count) TYPE i.