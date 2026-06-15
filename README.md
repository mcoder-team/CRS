# Console Rendering System 1.0B
Lightweight and easy to use library for easily making user interface in the console.

## Features
1. Full UTF-8 support (emojis, special symbols).
2. Optimized circle and rectangle drawing system with Aspect Ratio support for circles.
3. Text alignment system.

## Installation
Put `CRS.lua` in your project folder and use the `require` function:
`local crs = require("CRS")`

## Documentation

### Drawing
(None of them have return values, except `drawSymbol`)

1. `crs.drawSymbol(symbol, x, y)`
Draws a symbol on the screen with the given x and y coordinates. Returns the symbol if successful, or `nil` if coordinates are out of bounds.

2. `crs.drawRect(x, y, symbol, bool: fill, width, height)`
Draws a rectangle on the screen with the given x and y coordinates and with the given width and height values.
If `fill` is true, fills the rectangle, only draws the borders otherwise.

3. `crs.drawCircle(x, y, radius, symbol, bool: fill, float: aspect)`
Draws a circle with the given radius. 
`aspect` stretches or squeezes the circle horizontally/vertically (defaults to `1.8` to match standard console text grids).
If `fill` is true, fills the circle, only draws the borders otherwise.

4. `crs.drawText(text, x, y, string: align)`
Draws text with support for UTF-8 characters. 
`align` can be `"left"`, `"center"`, or `"right"` (defaults to `"left"`).

---

### Screen
(None of them have return values)

1. `crs.ps()`
Prints out the screen to the terminal window, clearing the previous frame.

2. `crs.cleanScr()`
Clears the current screen table using the background symbol (`filler`).

3. `crs.setScreenSize(width, height, bool: no_clear)`
Sets the size of the screen to the given width and height values.
If `no_clear` is true, it preserves current buffer data, otherwise it automatically clears the screen.

4. `crs.setBG(symbol, bool: no_clear)`
Changes the background symbol (`filler`).
If `no_clear` is true, it preserves current screen contents, otherwise it automatically clears the screen with the new background.

---

### Getters & Advanced
(Functions for reading buffer state or manually managing data)

1. `crs.getSymbolAt(x, y, bool: return_index)`
If `return_index` is true, returns the mathematical 1D index of the pixel inside the screen table. 
If false, returns the actual character stored at those coordinates.

2. `crs.getScreenSize()`
Returns a table containing current screen dimensions: `{width = X, height = Y}`.

3. `crs.getBG()`
Returns the current background symbol as a string.

4. `crs.getScreen()`
Returns the entire screen buffer flattened into a single combined string.

5. `crs.getScreen_TABLE()`
Returns the raw screen array (`scr`) containing every pixel sequentially.

6. `crs.setScreen(table: screen)`
Changes the internal "scr" table (stores every pixel) to the given value.
