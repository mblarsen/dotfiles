; extends

; Inject CSS into template literals passed as arguments to `css` function
; Example: const styles = css`color: red;`;
; :InspectTree shows: call_expression -> function: (identifier), arguments: (template_string)
(call_expression
  function: (identifier) @_tag
  arguments: (template_string) @injection.content
  (#match? @_tag "^css$")
  (#set! injection.language "styled")
)

; Inject CSS into template literals used with `styled.*` calls (styled-components/emotion)
; Example: const Button = styled.button<...>`color: blue;`;
; :InspectTree shows: call_expression -> function: (...(member_expression object: (identifier) property: (_)...), arguments: (template_string)
(call_expression
  function: (_
    (member_expression
      object: (identifier) @_obj
      property: (_)
    )
  )
  arguments: (template_string) @injection.content
  (#match? @_obj "^styled$")
  ; Temporarily remove #set! for playground testing
)
