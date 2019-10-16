pragma Singleton
import QtQuick 2.4

QtObject {
    //black & white
    readonly property color black_8 : "#80000000";
    readonly property color black_3 : "#33000000";
    readonly property color black_a : "#aa000000";
    readonly property color clouds: "#ecf0f1";
    readonly property color concrete: "#95a5a6";
    readonly property color white : "white"
    readonly property color silver : "#bdc3c7"
    readonly property color asbestos: "#7f8c8d";
    readonly property color background : "#e8ecef"
    readonly property color pane : "#F0F0F0"
    readonly property color gray : "#808080"
    readonly property color brown : "#785027"
    readonly property color black : "black"
    readonly property color transparent : "transparent"
    //dark
    readonly property color wetAsphalt   : "#34495e"
    readonly property color midnightBlue : "#2c3e50"
    readonly property color bluish_black : "#00171f";

    //blue
    readonly property color whiteBlue : "#aaeeff"
    readonly property color brightBlue : "#10bbEE"
    readonly property color light_blue : "#03a9f4";
    readonly property color peterRiver   : "#3498db"
    readonly property color blue : "#1E90FF"
    readonly property color dark_blue : "#3E65FF"
    readonly property color belize_hole: "#2980b9";
    readonly property color sorme : "#222A52";
    readonly property color indigo : "#264348"
    readonly property color dark_blue2 : "#00395f"
    //purple
    readonly property color purple : "#6A5ACD"
    readonly property color wisteria      : "#8e44ad"
    readonly property color amethyst: "#9b59b6";

    //yellow
    readonly property color yellow : "#FFEB3B"
    readonly property color lime : "#cddc39"
    readonly property color lime2 : "#a4c400"

    //orange
    readonly property color dark_orange : "#ff5722"
    readonly property color sunFlower    : "#f1c40f"
    readonly property color carrot: "#e67e22";
    readonly property color orange: "#f39c12"
    readonly property color pumpkin       : "#d35400"


    //red
    readonly property color red: "#e74c3c";
    readonly property color pomegranate   : "#c0392b"
    readonly property color radical : "#F62459"
    //green
    readonly property color emerald: "#2ecc71";
    readonly property color nephritis     : "#27ae60"
    readonly property color greenSea: "#16A085";
    readonly property color brightGreen:"#90EE90";

    //teal
    readonly property color turquoise: "#1ABC9C";
    readonly property color teal :"#00A2A7";

    // Brand colors
    readonly property color cobalt : dark_blue
    readonly property color primary   : wetAsphalt
    readonly property color secondary : turquoise
    readonly property color success   : emerald
    readonly property color warning   : sunFlower
    readonly property color danger    : red
    readonly property color info      : peterRiver

    // Settings for some of the most global styles.
    readonly property color textColor : primary

    // Global textual link color.
    readonly property color link_color       : greenSea
    readonly property color link_hover_color : turquoise
}
