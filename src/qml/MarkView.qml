import QtQuick 2.0
import com.canonical.Oxide 1.9
import Ubuntu.Web 0.2


WebView {
    id: webview
    objectName: "markView"

    readonly property string usContext: "oxide://"

    context: WebContext {
        id: webcontext
        userScripts: UserScript {
            id: userScript
            objectName: "userScript"
            context: webview.usContext
            url: userScriptUrl
        }
    }

    onJavaScriptConsoleMessage: {
        if (level == WebView.LogSeverityInfo)   {
            if (message.indexOf("http") == 0)
                Qt.openUrlExternally(message);
        }
    }
}
