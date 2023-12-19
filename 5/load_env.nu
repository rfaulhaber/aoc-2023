def main [] {
    luarocks path
            | lines
            | each { parse "export {variable}={path}" }
            | flatten
            | reduce {|it, acc| $acc | merge { ($it | get variable): ($it | get path) }  } --fold {}
}
