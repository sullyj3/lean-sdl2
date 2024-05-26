import Lake
open System Lake DSL

package sdl2

-- require alloy from ".."/".."
require alloy from git "https://github.com/tydeu/lean4-alloy.git"

module_data alloy.c.o.export : BuildJob FilePath
module_data alloy.c.o.noexport : BuildJob FilePath
lean_lib SDL2 where
  precompileModules := true
  nativeFacets := fun shouldExport =>
    if shouldExport then
      #[Module.oExportFacet, `alloy.c.o.export]
    else
      #[Module.oNoExportFacet, `alloy.c.o.noexport]

  moreLinkArgs := #["-lSDL2"]

lean_lib Test

@[default_target]
lean_exe sdl2_exe where
  root := `Main
