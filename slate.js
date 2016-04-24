// configs
slate.configAll({
  "defaultToCurrentScreen" : true,
  "secondsBetweenRepeat" : 0.1,
  "windowHintsShowIcons" : false,
  "focusCheckWidthMax" : 500,
  "gridCellRoundedCornerSize" : 2,
  "switchStopRepeatAtEdge" : false,
  "windowHintsSpread" : true,
  "windowHintsIgnoreHiddenWindows" : true
});

// grid setting
var grid = slate.operation("grid", {
  "grids" : {
    "1440x900" : {
      "width" : 6,
      "height" : 4
    }
  },
  "padding" : 1
});

// hints
var hint = slate.operation("hint", {
  "characters" : "ASDFGHJKL"
});

// 1/2 corners
var cornerTL = slate.operation("corner", {
  "direction" : "top-left",
  "width" : "screenSizeX/2",
  "height" : "screenSizeY/2"
});
var cornerTR = cornerTL.dup({ "direction" : "top-right" });
var cornerBL = cornerTL.dup({ "direction" : "bottom-left" });
var cornerBR = cornerTL.dup({ "direction" : "bottom-right" });

// 1/3 corners
var corner3TL = S.op("move", {
	"width" : "screenSizeX/3",
	"height" : "screenSizeY/2",
	"x" : "screenOriginX",
	"y" : "screenOriginY"
});
var corner3TM = corner3TL.dup({"x" : "screenOriginX+screenSizeX/3"});
var corner3TR = corner3TL.dup({"x" : "screenOriginX+2*screenSizeX/3"});
var corner3BL = corner3TL.dup({"y" : "screenOriginY+screenSizeY/2"});
var corner3BM = corner3TM.dup({"y" : "screenOriginY+screenSizeY/2"});
var corner3BR = corner3TR.dup({"y" : "screenOriginY+screenSizeY/2"});

// 1/2 and full screen filling
var simpleFull = S.op("move", {
  "x" : "screenOriginX",
  "y" : "screenOriginY",
  "width" : "screenSizeX",
  "height" : "screenSizeY"
});
var simpleSemiFull = S.op("move", {
  "x" : "screenOriginX+screenSizeX/4",
  "y" : "screenOriginY+screenSizeY/4",
  "width" : "screenSizeX/2",
  "height" : "screenSizeY/2"
});
var simpleT = simpleFull.dup({ "height" : "screenSizeY/2" });
var simpleB = simpleT.dup({ "y" : "screenOriginY+screenSizeY/2" });
var simpleL = simpleFull.dup({ "width" : "screenSizeX/2" });
var simpleR = simpleL.dup({ "x" : "screenOriginX+screenSizeX/2" });

// 1/3 screen filling
var simple3L = simpleFull.dup({"width" : "screenSizeX/3"});
var simple3M = simple3L.dup({"x" : "screenOriginX+screenSizeX/3"});
var simple3R = simple3L.dup({"x" : "screenOriginX+2*screenSizeX/3"});


// key bindings
slate.bindAll({
  // laptop keyboard window placements
  "l:alt,shift" : simple3R,
  "k:alt,shift" : simple3M,
  "j:alt,shift" : simple3L,

  "p:alt,shift" : simpleR,
  "o:alt,shift" : simpleL,

  "i:alt,shift" : simpleFull,

  // full keyboard window placements
  "pad6:shift" : simpleR,
  "pad4:shift" : simpleL,
  "pad8:shift" : simpleT,
  "pad2:shift" : simpleB,

  "pad0:shift" : simpleFull,
  "pad5:shift" : simpleSemiFull,

  "pad7:shift" : cornerTL,
  "pad9:shift" : cornerTR,
  "pad1:shift" : cornerBL,
  "pad3:shift" : cornerBR,

  "pad7:alt" : simple3L,
  "pad8:alt" : simple3M,
  "pad9:alt" : simple3R,

  "pad4:alt" : corner3TL,
  "pad5:alt" : corner3TM,
  "pad6:alt" : corner3TR,
  "pad1:alt" : corner3BL,
  "pad2:alt" : corner3BM,
  "pad3:alt" : corner3BR,

  // grid,hints
  "n:alt,shift" : grid,
  "m:alt,shift" : hint
});
