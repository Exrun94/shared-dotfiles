;;extends

((template_string) @injection.content
 (#lua-match? @injection.content "^`[%s\n]*<")
 (#set! injection.language "html")
 (#set! injection.include-children))
