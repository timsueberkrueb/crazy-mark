oxide.addMessageHandler("RENDER", function (msg) {
    var event = new CustomEvent("RENDER", {detail: msg.args});
    document.dispatchEvent(event);
    msg.reply({});
});
