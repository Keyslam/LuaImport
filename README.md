# LuaImport

> Simple relative `import()` helper for Lua.

📦 Write imports like `import("../utils/math")` without fiddling with `package.path` or converting paths to module names manually.\
✅ Works seamlessly with [qeffects/luals-relative-require](https://github.com/qeffects/luals-relative-require) to enable Sumneko Lua LSP support for relative imports.

## What it does

LuaImport lets you use file-style relative paths in your `require` calls. It resolves paths relative to the calling file and converts them into standard Lua module names.

* Use `..` to go up a directory
* Use `./` to refer to the current file’s directory
* Use `/` to start from the base (standard Lua `require` behavior)

This makes organizing and refactoring Lua code much easier, especially in larger projects.

## Recommended usage

At the top of your main file, enable `import()` globally:

```lua
_G.import = require("luaimport").import
```

You can now use `import()` anywhere in your codebase:

```lua
local utils = import("../common/utils")
```

## For libraries

If you're writing a library and want to avoid polluting the global namespace, you can use `useImport` to temporarily enable `import()`:

```lua
local useImport = require("luaimport").useImport

useImport(function()
    local thing = import("./something")
    -- use `thing` here
end)
```

## Installation

Clone or download the repository and place it somewhere in your project. For example:

```
your-project/
├── luaimport/
│   ├── init.lua
│   ├── README.md
│   └── LICENSE
└── main.lua
```

Then in your code:

```lua
local luaimport = require("luaimport")
```

Or if you've followed the recommended setup:

```lua
_G.import = require("luaimport").import
```

## License

MIT License – see `LICENSE` for details.