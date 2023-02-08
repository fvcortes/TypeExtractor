# TypeExtractor

This program implements a profiler to extract function types of a Lua program.

## Modules:

* Type.lua: Implements a sophisitcated type representation.

* Inspect.lua: Access local variables to extract parameter and return types.

* Hook.lua: Implements a profiler capable of inspecting functions at call and return events.

* Report.lua: Responsible for generating a report with function information.

* Test.lua: Makes type comparison based on types which we know the output.

* Run.lua: Responsible for loading a Lua file and configuring the hook function.

* Main.lua: Receives a Lua program as parameter and run the file.

## Usage:

```bash
lua Main.lua <program> <args>
```

Where "program" is a Lua program file (including path) and args are the programs args if needed.
  
A report will be printed in stdout with information about the types of called functions.

## Contact:

If any explanation is needed, you can contact me: fvcortes _at_ inf.puc-rio.br

