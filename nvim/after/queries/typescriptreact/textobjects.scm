; extends

; JSX attributes as parameters (entire attribute including value)
(jsx_attribute) @parameter.outer

; For inner selection, include the whole attribute value
(jsx_attribute
  (_) @parameter.inner)

; Function parameters (original behavior)
(formal_parameters
  (required_parameter) @parameter.inner
  (optional_parameter) @parameter.inner) @parameter.outer

; JSX spread attributes
(jsx_opening_element
  (jsx_expression) @parameter.outer)
(jsx_opening_element
  (jsx_expression) @parameter.inner)