#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQuickItem>
#include <QQuickTextDocument>
#include <QSyntaxHighlighter>
#include <QFile>
#include <QFileInfo>
#include <QtQml>
#include "markhighlighter.h"
#include "palette.h"
#include "desktopfiledialog.h"
#include "markfile.h"
#include "settings.h"
#include <QDebug>

const QString APP_FOLDER_NAME = "/crazy-mark.timsueberkrueb/";
const QString CONFIG_FILE_PATH = QStandardPaths::writableLocation(QStandardPaths::ConfigLocation) + APP_FOLDER_NAME;
const QString CACHE_FILE_PATH = QStandardPaths::writableLocation(QStandardPaths::CacheLocation) + APP_FOLDER_NAME;
const QString DATA_PATH = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + APP_FOLDER_NAME;
const QString DOCUMENTS_LOCATION = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    DesktopFileDialog desktopFileDialog;
    Settings settings(CONFIG_FILE_PATH);
    settings.load();

    bool confined = false;
    QString testFilename(DOCUMENTS_LOCATION + "/" + ".crazy-mark-test");
    QFile testFile(testFilename);
    if (!testFile.open(QIODevice::WriteOnly | QIODevice::Text))
        confined = true;
    else {
        testFile.close();
        QFile::remove(testFilename);
    }

    if (confined)
        qDebug() << "Running in confined mode.";
    else
        qDebug() << "Running unconfined.";

    QQmlApplicationEngine engine;
    qmlRegisterType<MarkFile>("Mark", 1, 0, "MarkFile");
    qmlRegisterType<Settings>("Mark", 1, 0, "Settings");
    engine.rootContext()->setContextProperty("confined", confined);
    engine.rootContext()->setContextProperty("settings", &settings);
    engine.rootContext()->setContextProperty("appVersion", "0.1");
    engine.rootContext()->setContextProperty("dataPath", DATA_PATH);
    engine.rootContext()->setContextProperty("documentsPath", DOCUMENTS_LOCATION);
    engine.rootContext()->setContextProperty("userScriptUrl", QUrl("file://"+QFileInfo("oxide-user.js").absoluteFilePath()));
    engine.rootContext()->setContextProperty("desktopFileDialog", &desktopFileDialog);
    engine.load(QUrl(QStringLiteral("qrc:///Main.qml")));

    // Load palette from help
    QObject *rootItem = engine.rootObjects()[0];
    QObject *paletteHelper = rootItem->findChild<QObject*>("paletteHelper");

    Palette palette(paletteHelper);

    // Install highlighter
    QQuickItem *textArea = rootItem->findChild<QQuickItem*>("markTextArea");
    QQuickTextDocument* doc = textArea->property("textDocument").value<QQuickTextDocument*>();
    new MarkHighlighter(palette, doc->textDocument());

    // Load marked js
    QFile markedJSFile(":/marked.js");
    if (!markedJSFile.open(QIODevice::ReadOnly)) {
        qWarning("Could not open marked.js file.");
    }
    QString markedJS = QString(markedJSFile.readAll().constData());

    // Load webview html
    QFile viewFile(":/view.html");
    if (!viewFile.open(QIODevice::ReadOnly)) {
        qWarning("Could not open view file.");
    }
    QString viewHtml = QString(viewFile.readAll().constData());
    viewHtml.replace("$$(MARKED_JS)", markedJS);
    viewHtml.replace("$$(BODY_COLOR)", palette.midGrey.name());
    viewHtml.replace("$$(A_COLOR)", palette.orange.name());

    // Prepare webview
    QQuickItem *webView = rootItem->findChild<QQuickItem*>("markView");
    QMetaObject::invokeMethod(webView, "loadHtml", Q_ARG(QString, viewHtml));

    //engine.show();

    return app.exec();
}

