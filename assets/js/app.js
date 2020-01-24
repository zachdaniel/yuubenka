// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";
// import { toKana, toRomaji } from "wanakana";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

import LiveSocket from "phoenix_live_view";

let Hooks = {};
Hooks.ToKana = {
  updated() {
    this.el.value = this.el.getAttribute("data-to-kana")
    if (this.el.getAttribute("data-to-kana") == "true") {
      this.el.value = this.el.getAttribute("data-kana")
    } else if (this.el.value != this.el.getAttribute("data-romaji")) {
      this.el.value = this.el.getAttribute("data-romaji")
    }
  }
};

let liveSocket = new LiveSocket("/live", { hooks: Hooks });
liveSocket.connect();
